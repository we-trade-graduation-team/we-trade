import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:search_choices/search_choices.dart';
import '../../../constants/app_colors.dart';
import '../../../services/post_feature/post_service_firestore.dart';

import '../component/class.dart';
import 'post_item_step_three.dart';

class PostItemTwo extends StatefulWidget {
  const PostItemTwo({Key? navKey}) : super(key: navKey);
  static final navKey = GlobalKey<NavigatorState>();

  static const routeName = '/postitem2';
  @override
  _PostItemTwoState createState() => _PostItemTwoState();
}

class _PostItemTwoState extends State<PostItemTwo> {
  PostServiceFireStore dataServiceFireStore = PostServiceFireStore();
  bool isLoading = true;
  //argument for next screen
  late TypeOfGoods mainCategory = TypeOfGoods(id: '', name: '');
  late TypeOfGoods subCategory = TypeOfGoods(id: '', name: '');
  List<String> newKeywordID = [];
  late Conditions conditions;
  late List<String> keywordToSave = [];
  late List<String> idKeywordToSave = [];

  //Category
  List<TypeOfGoods> _type = [];
  List<TypeOfGoods> _subType = [];
  late String previousID = '-1';

  //keyWord Choice
  List<DropdownMenuItem> editableItems = [];
  List<int> editableSelectedItems = [];
  final _formKey = GlobalKey<FormState>();
  TextFormField? input;
  late List<KeyWord> listKeyWord = [];
  Function? openDialog;
  String inputString = '';

  //Conditions
  List<Conditions> conditionsList = [];

  //Function
  Future<List<TypeOfGoods>> getMainCategoryData() {
    final _tempCategory = <TypeOfGoods>[];
    return dataServiceFireStore.getMainCategory().then((value) {
      for (final item in value.docs) {
        final itemCate =
            TypeOfGoods(id: item.id, name: item.data()['category'].toString());
        _tempCategory.add(itemCate);
      }
      return _tempCategory;
    });
  }

  Future<List<TypeOfGoods>> getSubCategoryData(String main) {
    final _typeSubTemp = <TypeOfGoods>[];
    return dataServiceFireStore.getSubCategory(main).then((value) {
      for (final item in value.docs) {
        final subCate = TypeOfGoods(
            id: item.id, name: item.data()['subCategory'].toString());
        _typeSubTemp.add(subCate);
      }
      return _typeSubTemp;
    });
  }

  Future<List<KeyWord>> getListKeyword() {
    final _tempCategory = <KeyWord>[];
    return dataServiceFireStore.getKeyword().then((value) {
      for (final item in value.docs) {
        final keyword =
            KeyWord(id: item.id, value: item.data()['keyword'].toString());
        _tempCategory.add(keyword);
      }
      return _tempCategory;
    });
  }

  Future<List<Conditions>> getConditions() {
    final _typeSubTemp = <Conditions>[];
    return dataServiceFireStore.getCondition().then((value) {
      for (final item in value.docs) {
        final subCate = Conditions(
            priority: item.data()['priority'] as int,
            description: item.data()['description'].toString());
        _typeSubTemp.add(subCate);
      }
      return _typeSubTemp;
    });
  }

  Widget categoryDropDown() => DropdownButton<TypeOfGoods>(
        value: _type.isNotEmpty ? mainCategory : null,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (newValue) {
          setState(() {
            mainCategory = newValue!;
            isLoading = true; //thành loading
          });
        },
        items: _type.isNotEmpty
            ? _type.map<DropdownMenuItem<TypeOfGoods>>((value) {
                return DropdownMenuItem<TypeOfGoods>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList()
            : [],
      );

  Widget subCategoryDropDown() => DropdownButton<TypeOfGoods>(
        value: _subType.isNotEmpty ? subCategory : null,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (newValue) {
          setState(() {
            subCategory = newValue!;
          });
        },
        items: _subType.isNotEmpty
            ? _subType.map<DropdownMenuItem<TypeOfGoods>>((value) {
                return DropdownMenuItem<TypeOfGoods>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList()
            : [],
      );

  Widget conditionsDropDown() => DropdownButton<Conditions>(
        value: conditionsList.isNotEmpty ? conditions : null,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (newValue) {
          setState(() {
            conditions = newValue!;
          });
        },
        items: conditionsList.isNotEmpty
            ? conditionsList.map<DropdownMenuItem<Conditions>>((value) {
                return DropdownMenuItem<Conditions>(
                    value: value, child: Text(value.description));
              }).toList()
            : [],
      );

  Future<dynamic> addItemDialog() {
    return showDialog<dynamic>(
      context: PostItemTwo.navKey.currentState?.overlay?.context ?? context,
      builder: (alertContext) {
        return AlertDialog(
          title: const Text('Nhập keyword'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                input ?? const SizedBox.shrink(),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      editableItems.add(DropdownMenuItem<dynamic>(
                        value: inputString,
                        child: Text(inputString),
                      ));
                      dataServiceFireStore
                          .addKeyword(inputString)
                          .then((newkeywordId) {
                        final keyword =
                            KeyWord(id: newkeywordId, value: inputString);
                        listKeyWord.add(keyword);
                        print(keyword.value);
                      });
                      Navigator.pop(alertContext, inputString);
                    }
                  },
                  child: const Text('Xác nhận'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(alertContext, 'null');
                  },
                  child: const Text('Hủy'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<String>> getKeywordToSave() async {
    try {
      final tempKeyword = <String>[];
      for (var i = 0; i < editableSelectedItems.length; i++) {
        tempKeyword
            .add(editableItems[editableSelectedItems[i]].value.toString());
        idKeywordToSave.add(listKeyWord
            .firstWhere((element) => tempKeyword[i] == element.value.toString()
                //  && element.id != 'new'
                )
            .id);
      }
      return tempKeyword;
    } catch (e) {
      rethrow;
    }
  }

  Widget keyWordChoice() {
    return SearchChoices<dynamic>.multiple(
        items: editableItems,
        selectedItems: editableSelectedItems,
        hint: 'Chọn keyword',
        searchHint: 'Chọn keyword',
        disabledHint: (dynamic updateParent) {
          return TextButton(
            onPressed: () {
              addItemDialog().then((dynamic value) {
                editableSelectedItems = [0];
                updateParent(editableSelectedItems);
              });
            },
            child: const Text('Chưa có keyword, hãy nhập vào 1 keyword'),
          );
        },
        closeButton:
            (dynamic values, dynamic closeContext, dynamic updateParent) {
          return editableItems.length >= 100
              ? 'Đóng'
              : TextButton(
                  onPressed: () {
                    addItemDialog().then((dynamic value) async {
                      final itemIndex = editableItems
                          .indexWhere((element) => element.value == value);
                      if (itemIndex != -1) {
                        editableSelectedItems.add(itemIndex);
                        Navigator.pop(closeContext as BuildContext);
                        updateParent(editableSelectedItems);
                      }
                    });
                  },
                  child: const Text('Thêm Keyword'),
                );
        },
        onChanged: (dynamic values) {
          if (values is! NotGiven) {
            editableSelectedItems = values as List<int>;
          }
        },
        displayItem: (dynamic item, dynamic selected, dynamic updateParent) {
          return Row(children: [
            if (selected as bool)
              const Icon(
                Icons.check_box,
                color: Colors.blue,
              )
            else
              const Icon(
                Icons.check_box_outline_blank,
                color: Colors.blue,
              ),
            const SizedBox(width: 7),
            Expanded(
              child: item as DropdownMenuItem,
            ),
          ]);
        },
        isExpanded: true,
        selectedValueWidgetFn: (dynamic item) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Text(
              item as String,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        selectedAggregateWidgetFn: (dynamic list) {
          return Column(children: [
            Align(
                alignment: Alignment.topLeft,
                child: Wrap(children: list as List<Widget>)),
          ]);
        });
  }

  void _showMessgage() {
    // flutter defined function
    showDialog<dynamic>(
      context: context,
      builder: (arlertContext) {
        // return object of type Dialog
        return AlertDialog(
          //title: const Text(''),
          content: const Text('Bạn chưa chọn keyword'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              onPressed: () {
                Navigator.of(arlertContext).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    input = TextFormField(
      validator: (value) {
        return (value?.length ?? 0) < 3 ? 'Ít nhất 3 kí tự' : null;
      },
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );
    getListKeyword().then((value) {
      listKeyWord = value;
      var wordPair = '';
      for (final word in listKeyWord) {
        wordPair = word.value;
        if (editableItems.indexWhere((item) {
              return item.value == wordPair;
            }) ==
            -1) {
          editableItems.add(DropdownMenuItem<dynamic>(
            value: wordPair,
            child: Text(wordPair),
          ));
        }
        wordPair = '';
      }
    });
    getConditions().then((value) {
      conditionsList = value;
      conditions = value.first;
    });

    getMainCategoryData().then((value) {
      setState(() {
        _type = value;
        mainCategory = value.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (mainCategory.id == '' || mainCategory.id == previousID) {
      //no run getSub when setState
      setState(() {
        isLoading = false;
      });
    } else {
      getSubCategoryData(mainCategory.name).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            _subType = value;
            subCategory = value.first;
            previousID = mainCategory.id;
            isLoading = false;
          });
        } else {
          setState(() {
            _subType = [];
            previousID = mainCategory.id;
            isLoading = false;
          });
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Tạo bài đăng mới - 2',
            style: TextStyle(color: AppColors.kTextColor)),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        child: Text('Phân loại cho sản phẩm của bạn',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Danh mục chính',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    if (mainCategory.id != '')
                      categoryDropDown()
                    else
                      Container(),
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Danh mục phụ',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    subCategoryDropDown(),
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Tình trạng',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    conditionsDropDown(),
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Từ khóa',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    keyWordChoice(),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.maxFinite, // set width to maxFinite
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.kPrimaryLightColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          if (editableSelectedItems.isEmpty) {
                            _showMessgage();
                          } else {
                            getKeywordToSave()
                                .then((keywords) => keywordToSave = keywords)
                                .whenComplete(() {
                              pushNewScreenWithRouteSettings<void>(
                                context,
                                settings: RouteSettings(
                                    name: PostItemThree.routeName,
                                    arguments: {
                                      'name': arguments['name'] as String,
                                      'description':
                                          arguments['description'] as String,
                                      'imageURL':
                                          arguments['imageURL'] as List<Asset>,
                                      'mainCategory': mainCategory.id,
                                      'subCategory': subCategory.id,
                                      'condition': conditions.description,
                                      'keyword': keywordToSave,
                                      'keywordId': idKeywordToSave,
                                    }),
                                screen: const PostItemThree(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            });
                          }
                        },
                        child: const Text('Tiếp theo'),
                      ),
                    ),
                  ],
                )),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));

    properties.add(DiagnosticsProperty<PostServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
    properties.add(
        IterableProperty<int>('editableSelectedItems', editableSelectedItems));
    properties.add(StringProperty('inputString', inputString));
    properties.add(DiagnosticsProperty<Function?>('openDialog', openDialog));
    properties
        .add(IterableProperty<Conditions>('conditionList', conditionsList));
    properties.add(DiagnosticsProperty<Conditions>('conditions', conditions));
    properties
        .add(DiagnosticsProperty<TypeOfGoods>('mainCategory', mainCategory));
    properties
        .add(DiagnosticsProperty<TypeOfGoods>('subCategory', subCategory));
    properties.add(IterableProperty<String>('newKeywordID', newKeywordID));
    properties.add(IterableProperty<String>('keywordToSave', keywordToSave));
    properties.add(IterableProperty<KeyWord>('listKeyWord', listKeyWord));
    properties
        .add(IterableProperty<String>('idKeywordToSave', idKeywordToSave));
    properties.add(StringProperty('previousID', previousID));
  }
}

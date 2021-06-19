import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:search_choices/search_choices.dart';

import '../../../../constants/app_colors.dart';
import '../../../models/cloud_firestore/post_model/post/post.dart';
import 'update_post_step_four.dart';

class UpdatePostThree extends StatefulWidget {
  const UpdatePostThree({
    Key? key,
    required this.oldPost,
  }) : super(key: key);

  static final navKey = GlobalKey<NavigatorState>();
  final Post oldPost;
  static const routeName = '/postitem3';

  @override
  _UpdatePostThreeState createState() => _UpdatePostThreeState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Post>('oldPost', oldPost));
  }
}

class _UpdatePostThreeState extends State<UpdatePostThree> {
  late final Post _oldPostInfo = widget.oldPost;
  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  final _formKeyName = GlobalKey<FormState>();

  TextEditingController priceController = TextEditingController();
  late FocusScopeNode node;

  //PostServiceFireStore dataServiceFireStore = PostServiceFireStore();

  //keyWord Choice
  List<DropdownMenuItem> editableItems = [];
  List<int> editableSelectedItems = [];
  TextFormField? input;
  late List<String> tradeForList = [];
  Function? openDialog;
  String inputString = '';

  Future<dynamic> addItemDialog() {
    return showDialog<dynamic>(
      context: UpdatePostThree.navKey.currentState?.overlay?.context ?? context,
      builder: (alertContext) {
        return AlertDialog(
          title: const Text('Nhập tên sản phẩm'),
          content: Form(
            key: _formKeyName,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                input ?? const SizedBox.shrink(),
                TextButton(
                  onPressed: () {
                    if (_formKeyName.currentState?.validate() ?? false) {
                      editableItems.add(DropdownMenuItem<dynamic>(
                        value: inputString,
                        child: Text(inputString),
                      ));
                      Navigator.pop(alertContext, inputString);
                      setState(() {});
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

  Widget tradeForListWidget() {
    return SearchChoices<dynamic>.multiple(
      items: editableItems,
      selectedItems: editableSelectedItems,
      hint: 'Chọn tên sản phẩm bạn muốn đổi',
      searchHint: 'Chọn tên sản phẩm bạn muốn đổi',
      disabledHint: (dynamic updateParent) {
        return TextButton(
          onPressed: () {
            addItemDialog().then((dynamic value) {
              editableSelectedItems = [0];
              updateParent(editableSelectedItems);
            });
          },
          child: const Text('Nhập vào tên sản phẩm bạn muốn đổi'),
        );
      },
      closeButton:
          (dynamic values, dynamic closeContext, dynamic updateParent) {
        return editableItems.length >= 5
            ? 'Tối đa 5 sản phẩm'
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
                child: const Text('Thêm sản phẩm khác'),
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
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              final indexOfItem = editableItems.indexOf(item);
              editableItems.removeWhere((element) => item == element);
              editableSelectedItems
                  .removeWhere((element) => element == indexOfItem);
              for (var i = 0; i < editableSelectedItems.length; i++) {
                if (editableSelectedItems[i] > indexOfItem) {
                  editableSelectedItems[i]--;
                }
              }
              updateParent(editableSelectedItems);
              setState(() {});
            },
          ),
        ]);
      },
      isExpanded: true,
    );
  }

  Future<List<String>> getTradeForList() async {
    try {
      final tempKeyword = <String>[];
      for (var i = 0; i < editableSelectedItems.length; i++) {
        tempKeyword
            .add(editableItems[editableSelectedItems[i]].value.toString());
      }
      return tempKeyword;
    } catch (e) {
      rethrow;
    }
  }

  void _showMessgage() {
    // flutter defined function
    showDialog<dynamic>(
      context: context,
      builder: (arlertContext) {
        // return object of type Dialog
        return AlertDialog(
          //title: const Text(''),
          content: const Text('Bạn chua nhập sản phẩm muốn đổi'),
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

  Future<void> loadingOldValue() async {
    for (final word in _oldPostInfo.tradeForList) {
      if (editableItems.indexWhere((item) {
            return item.value == word;
          }) ==
          -1) {
        editableItems.add(DropdownMenuItem<dynamic>(
          value: word,
          child: Text(word),
        ));
      }
      editableSelectedItems.add(editableItems.indexWhere((item) {
        return item.value == word;
      }));
    }
    priceController.text = _oldPostInfo.price.toString();
  }

  @override
  void initState() {
    super.initState();
    input = TextFormField(
      validator: (value) {
        return ((value?.length ?? 0) < 3)
            ? 'Tên sản phẩm có ít nhất 3 kí tự'
            : null;
      },
      maxLength: 25,
      initialValue: inputString,
      onChanged: (value) {
        inputString = value;
      },
      autofocus: true,
    );
    if (_oldPostInfo.postId != null) {
      loadingOldValue().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: AppColors.kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Chỉnh sửa bài đăng - 3',
            style: TextStyle(color: AppColors.kTextColor)),
      ),
      body: GestureDetector(
        onTap: () {
          node.unfocus();
        },
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text('Nhập tên sản phẩm bạn muốn đổi',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.kSecondaryLightColor)),
                          child: tradeForListWidget()),
                      const SizedBox(
                        height: 25,
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text('Định giá cho sản phẩm của bạn (VNĐ): ',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilder(
                        key: _formKey,
                        onChanged: () {},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'price',
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: AppColors.kTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.numeric(context,
                                    errorText: 'Nhập giá trị số'),
                                FormBuilderValidators.min(context, 1000)
                              ]),
                              onEditingComplete: () => node.unfocus(),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.maxFinite, // set width to maxFinite
                              child: TextButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.kPrimaryLightColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor)),
                                onPressed: () {
                                  if (_formKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    if (editableSelectedItems.isEmpty) {
                                      _showMessgage();
                                    } else {
                                      getTradeForList().then((value) {
                                        tradeForList = value;
                                      }).whenComplete(() {
                                        pushNewScreenWithRouteSettings<void>(
                                          context,
                                          settings: RouteSettings(
                                            name: UpdatePostFour.routeName,
                                            arguments: {
                                              'name':
                                                  arguments['name'] as String,
                                              'description':
                                                  arguments['description']
                                                      as String,
                                              'imagesUrl': arguments['imageURL']
                                                  as List<Asset>,
                                              'mainCategoryId':
                                                  arguments['mainCategory']
                                                      as String,
                                              'subCategoryId':
                                                  arguments['subCategory']
                                                      as String,
                                              'condition':
                                                  arguments['condition']
                                                      as String,
                                              'keyword': arguments['keyword']
                                                  as List<String>,
                                              'keywordId':
                                                  arguments['keywordId']
                                                      as List<String>,
                                              'price': int.parse(
                                                  priceController.text),
                                              'tradeForList': tradeForList,
                                              'oldPost': _oldPostInfo,
                                            },
                                          ),
                                          screen: const UpdatePostFour(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      });
                                    }
                                  }
                                },
                                child: const Text('Tiếp theo'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'priceController', priceController));
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
    properties.add(DiagnosticsProperty<Function?>('openDialog', openDialog));
    properties.add(
        IterableProperty<int>('editableSelectedItems', editableSelectedItems));
    properties.add(StringProperty('inputString', inputString));
    properties.add(IterableProperty<String>('tradeForList', tradeForList));
  }
}

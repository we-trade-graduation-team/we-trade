import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import 'postitem_stepthree.dart';

class PostItemTwo extends StatefulWidget {
  const PostItemTwo({Key? key}) : super(key: key);
  static const routeName = '/postitem2';

  @override
  _PostItemTwoState createState() => _PostItemTwoState();
}

class TypeofGoods {
  TypeofGoods({required this.id, required this.name, this.selected = false});
  final int id;
  bool selected;
  final String name;
}

class _PostItemTwoState extends State<PostItemTwo> {
  PostServiceFireStore dataServiceFireStore = PostServiceFireStore();
  bool isLoading = true;
  List<TypeofGoods> _type = [];
  List<TypeofGoods> _subType = [];

  String mainCategory = '';
  String subCategory = '';

  Future<List<TypeofGoods>> getMainCategoryData() {
    final _tempCategory = <TypeofGoods>[];
    return dataServiceFireStore.getMainCategory().then((value) {
      for (final item in value.docs) {
        final itemCate = TypeofGoods(
            id: int.parse(item.id),
            name: item.data()['category_name'].toString());
        _tempCategory.add(itemCate);
      }
      return _tempCategory;
    });
  }

  Future<List<TypeofGoods>> getSubCategoryData(String mainCategory) {
    final _typeSubTemp = <TypeofGoods>[];
    return dataServiceFireStore.getSubCategory(mainCategory).then((value) {
      var index = 0;
      for (final item in value.docs) {
        final subCate = TypeofGoods(
            id: index, name: item.data()['subCategory_name'].toString());
        _typeSubTemp.add(subCate);
        index++;
      }
      return _typeSubTemp;
    });
  }

  Widget categoryDropDown() => DropdownButton<String>(
        value: _type.isNotEmpty ? mainCategory : '',
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
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
            ? _type.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList()
            : [],
      );

  Widget subCategoryDropDown() => DropdownButton<String>(
        value: _subType.isNotEmpty ? subCategory : '',
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
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
            ? _subType.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList()
            : [],
      );

  @override
  void initState() {
    getMainCategoryData().then((value) {
      setState(() {
        _type = value;
        mainCategory = value[0].name;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments.isNotEmpty) {}

    getSubCategoryData(mainCategory).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _subType = value;
          if (value.any((element) => element.name == subCategory)) {
            isLoading = false;
          } else {
            subCategory = value[0].name;
            isLoading = false;
          }
        });
      } else {
        setState(() {
          _subType = [];
          isLoading = false;
        });
      }
    });
    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Đăng sản phẩm mới - 2',
            style: TextStyle(color: kTextColor)),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Phân loại cho sản phẩm',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Danh mục chính'),
                    if (mainCategory.isNotEmpty)
                      //Text(mainCategory.toString())
                      categoryDropDown()
                    else
                      const Text('Lấy data maincategory ko được'),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Danh mục phụ'),
                    subCategoryDropDown(),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Loại của sản phẩm là: ',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 240),
                        child: Column(
                          children: [
                            Text(mainCategory),
                            Text(subCategory),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite, // set width to maxFinite
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                kPrimaryLightColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kPrimaryColor)),
                        onPressed: () {
                          pushNewScreenWithRouteSettings<void>(
                            context,
                            settings: const RouteSettings(
                                name: PostItemThree.routeName),
                            screen: const PostItemThree(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
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
    properties.add(StringProperty('mainCategory', mainCategory));
    properties.add(StringProperty('subCategory', subCategory));
    properties.add(DiagnosticsProperty<PostServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
  }
}

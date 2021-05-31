import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
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
  bool isLoading = true;
  List<TypeofGoods> _type = [];
  List<TypeofGoods> _subType = [];

  Map<String, List<String>> mapSubCategory = <String, List<String>>{};
  String mainCategory = '';
  String subCategory = '';

  void getMainCategoryData() {
    //lấy data mainCategory
    final _typeTemp = <TypeofGoods>[];
    final CollectionReference category = FirebaseFirestore.instance
        .collection('thientin')
        .doc('category')
        .collection('categoryList');
    category.get().then((categoryType) {
      var index = 1;
      for (final type in categoryType.docs) {
        final tempType =
            TypeofGoods(id: index, name: type['category_name'].toString());
        if (_typeTemp.any((element) => element.id == tempType.id)) {
          index++;
        } else {
          _typeTemp.add(tempType);
          index++;
        }
      }
      setState(() {
        _type = _typeTemp; //Gán data cho List mainCategory
        mainCategory =
            _type[0].name; //Hiển thị phần tử đầu tiên trong dropdownButton
        getSubCategoryData(); // Lấy data subCategory, dựa theo phần tử dropdownButton đang chọn
      });
    });
  }

  void getSubCategoryData() {
    final _typeSubTemp = <TypeofGoods>[];
    final category = FirebaseFirestore.instance
        .collection('thientin')
        .doc('category')
        .collection('categoryList')
        .where('category_name', isEqualTo: mainCategory);
    category.get().then((categoryType) {
      for (final element in categoryType.docs) {
        var index = 1;
        element.reference
            .collection('subCategory')
            .get()
            .then((subCategoryType) => {
                  for (final subTypeData in subCategoryType.docs)
                    {
                      if (_typeSubTemp.any((element) =>
                          element.name == subTypeData['subCategory_name']))
                        {index++}
                      else
                        {
                          _typeSubTemp.add(TypeofGoods(
                              id: index,
                              name:
                                  subTypeData['subCategory_name'].toString())),
                          index++
                        }
                    }
                });
      }
      setState(() {
        _subType = _typeSubTemp; // Gán data cho List subCategory
        subCategory =
            _subType[0].name; //Hiển thị phần tử đầu tiên trong dropdownButton
        isLoading = false; // Hiển thị ra màn hình
      });
    });
  }

  Widget categoryDropDown() => DropdownButton<String>(
        value: mainCategory,
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
            //isLoading = true; //thành loading
            //_subType.clear();
          });
          //getSubCategoryData(mainCategory);
        },
        items: _type.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
      );

  Widget subCategoryDropDown() => DropdownButton<String>(
        value: subCategory,
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
        items: _subType.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
      );

  @override
  void initState() {
    super.initState();
    getMainCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments.isNotEmpty) {
      //print(arguments['item_name']);
    }

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
                    //subCategoryDropDown(),
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
    properties.add(DiagnosticsProperty<Map<String, List<String>>>(
        'mapSubCategory', mapSubCategory));
  }
}

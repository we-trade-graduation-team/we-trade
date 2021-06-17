import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../constants/app_colors.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import './component/class.dart';
import 'post_item_step_four.dart';

class PostItemThree extends StatefulWidget {
  const PostItemThree({Key? key}) : super(key: key);
  static const routeName = '/postitem3';

  @override
  _PostItemThreeState createState() => _PostItemThreeState();
}

class _PostItemThreeState extends State<PostItemThree> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController priceController = TextEditingController();
  late FocusScopeNode node;

  PostServiceFireStore dataServiceFireStore = PostServiceFireStore();
  List<TypeofGoods> _type = [];
  late TypeofGoods category1 = TypeofGoods(id: '', name: '');
  late TypeofGoods category2 = TypeofGoods(id: '', name: '');
  late TypeofGoods category3 = TypeofGoods(id: '', name: '');
  List<String> categoriesID = [];
  Future<List<TypeofGoods>> getMainCategoryData() {
    final _tempCategory = <TypeofGoods>[];
    return dataServiceFireStore.getMainCategory().then((value) {
      for (final item in value.docs) {
        final itemCate = TypeofGoods(
            id: item.id, name: item.data()['category_name'].toString());
        _tempCategory.add(itemCate);
      }
      return _tempCategory;
    });
  }

  Widget categoryDropDown(TypeofGoods mainCategory, int priority) {
    return DropdownButton<TypeofGoods>(
      value: _type.isNotEmpty ? mainCategory : null,
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
          switch (priority) {
            case 1:
              category1 = newValue!;
              break;
            case 2:
              category2 = newValue!;
              break;
            case 3:
              category3 = newValue!;
              break;
          }
        });
      },
      items: _type.isNotEmpty
          ? _type.map<DropdownMenuItem<TypeofGoods>>((value) {
              return DropdownMenuItem<TypeofGoods>(
                value: value,
                child: Text(value.name),
              );
            }).toList()
          : [],
    );
  }

  @override
  void initState() {
    super.initState();
    getMainCategoryData().then((value) {
      _type = value;
      category1 = value.first;
      category2 = value.first;
      category3 = value.first;
      isLoading = false;
    }).whenComplete(() => setState(() {}));
  }

  Future<List<String>> getWishCategoriesList() async {
    final tempList = <String>[];
    try {
      tempList.add(category1.id);
      tempList.add(category2.id);
      tempList.add(category3.id);
      return tempList;
    } catch (e) {
      rethrow;
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
        title: const Text('Tạo bài đăng mới - 3',
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
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              'Chọn những danh mục sản phẩm bạn muốn đổi',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Ưu tiên 1: '),
                      categoryDropDown(category1, 1),
                      const Text('Ưu tiên 2: '),
                      categoryDropDown(category2, 2),
                      const Text('Ưu tiên 3: '),
                      categoryDropDown(category3, 3),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text('Định giá cho sản phẩm (VNĐ): ',
                              style: TextStyle(fontWeight: FontWeight.bold))),
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
                                  getWishCategoriesList().then((value) {
                                    categoriesID = value;
                                  }).whenComplete(() {
                                    if (_formKey.currentState
                                            ?.saveAndValidate() ??
                                        false) {
                                      pushNewScreenWithRouteSettings<void>(
                                        context,
                                        settings: RouteSettings(
                                          name: PostItemFour.routeName,
                                          arguments: {
                                            'name': arguments['name'] as String,
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
                                            'condition': arguments['condition']
                                                as String,
                                            'keyword': arguments['keyword']
                                                as List<String>,
                                            'keywordId': arguments['keywordId']
                                                as List<String>,
                                            'tradeForListId': categoriesID,
                                            'price':
                                                int.parse(priceController.text),
                                          },
                                        ),
                                        screen: const PostItemFour(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    }
                                  });
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
    properties.add(DiagnosticsProperty<PostServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
    properties.add(DiagnosticsProperty<TypeofGoods>('category1', category1));
    properties.add(DiagnosticsProperty<TypeofGoods>('category2', category2));
    properties.add(DiagnosticsProperty<TypeofGoods>('category3', category3));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'priceController', priceController));
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
    properties.add(IterableProperty<String>('categoriesID', categoriesID));
  }
}

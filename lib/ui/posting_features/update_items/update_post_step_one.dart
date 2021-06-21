import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';


import '../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../services/firestore/firestore_database.dart';
import 'update_post_step_two.dart';

class UpdatePostOne extends StatefulWidget {
  const UpdatePostOne({
    Key? key,
    required this.postId,
  }) : super(key: key);

  static const routeName = '/update_item1';

  final String postId;

  @override
  _UpdatePostOneState createState() => _UpdatePostOneState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('postId', postId));
  }
}

class _UpdatePostOneState extends State<UpdatePostOne> {
  bool isLoading = true;
  List<Asset> images = <Asset>[]; //hiển thị danh sách images;
  List<String> oldImages = [];
  final _formKey = GlobalKey<FormBuilderState>();
  late Post _oldPostInfo;
  late FocusScopeNode node;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();

  Future<void> loadAssets() async {
    var resultList = <Asset>[]; //start here list ảnh trả ra tạm thời
    var error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: 'chat',
          doneButtonTitle: 'Fatto',
        ),
        materialOptions: const MaterialOptions(
          statusBarColor: '#CCD2E3',
          actionBarColor: '#6F35A5',
          actionBarTitle: 'CHỌN ẢNH',
          allViewTitle: 'All Photos',
          useDetailsView: false,
          selectCircleStrokeColor: '#ffffff',
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      log(error);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      images = resultList; //nếu chạy thành công thì setState hiện list ảnh lên
    });
  }

  Widget buildGridViewSelectedImages() {
    // hàm này show list ảnh images lên nè, m có thể chỉnh sửa tùy ý
    if (images.isNotEmpty) {
      return Stack(
        children: [
          SizedBox(
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(images.length, (index) {
                final asset = images[index];
                return AssetThumb(
                  asset: asset,
                  height: 200,
                  width: 200,
                );
              }),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget buildListOldImages() {
    // hàm này show list ảnh images lên nè, m có thể chỉnh sửa tùy ý
    if (_oldPostInfo.imagesUrl.isNotEmpty) {
      return Stack(
        children: [
          SizedBox(
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(_oldPostInfo.imagesUrl.length, (index) {
                final asset = _oldPostInfo.imagesUrl[index];
                return Image.network(
                  asset,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  // void _showMessgage() {
  //   // flutter defined function
  //   showDialog<dynamic>(
  //     context: context,
  //     builder: (arlertContext) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         //title: const Text(''),
  //         content: const Text('Bạn chưa chọn ảnh minh họa'),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(arlertContext).pop();
  //             },
  //             child: const Text('Đóng'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<Post> _getPostInfo(String postId) async {
    try {
      final _firebaseDatabase = context.read<FirestoreDatabase>();
      final _postInfo = await _firebaseDatabase.getPost(postId: postId);
      return _postInfo;
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _getPostInfo(widget.postId).then((value) {
      _oldPostInfo = value;
      itemNameController.text = value.name;
      itemDescriptionController.text = value.itemInfo.description;
    }).whenComplete(() {
      setState(() {
        isLoading = false;
        //log(_oldPostInfo.postId.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Chỉnh sửa bài đăng',
            style: TextStyle(color: AppColors.kTextColor)),
      ),
      body: GestureDetector(
        onTap: () {
          node.unfocus();
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    //ảnh minh họa
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Ảnh minh họa',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //hiển thị hình ảnh
                    Container(
                        height: screenHeight / 5,
                        child: images.isNotEmpty
                            ? buildGridViewSelectedImages()
                            : buildListOldImages()),
                    const SizedBox(
                      height: 15,
                    ),
                    //Upload - Change Image
                    Center(
                      widthFactor: screenWidth / 4,
                      child: TextButton(
                          onPressed: loadAssets,
                          child: images.isNotEmpty
                              ? const Text('Thay đổi ảnh')
                              : const Text('Chọn ảnh mới')),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FormBuilder(
                      key: _formKey,
                      onChanged: () {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'item_name',
                            controller: itemNameController,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              labelText: 'Tên sản phẩm',
                              labelStyle: TextStyle(
                                color: AppColors.kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.minLength(context, 5)
                            ]),
                            onEditingComplete: () => node.nextFocus(),
                          ),
                          const SizedBox(height: 30),
                          FormBuilderTextField(
                            name: 'item_description',
                            controller: itemDescriptionController,
                            textCapitalization: TextCapitalization.sentences,
                            minLines: 5,
                            maxLines: 15,
                            maxLength: 200,
                            decoration: const InputDecoration(
                              labelText: 'Mô tả sản phẩm',
                              labelStyle: TextStyle(
                                color: AppColors.kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.minLength(context, 10)
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
                                node.unfocus();
                                if (_formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  pushNewScreenWithRouteSettings<void>(
                                    context,
                                    settings: RouteSettings(
                                        name: UpdatePostTwo.routeName,
                                        arguments: {
                                          'name': itemNameController.text,
                                          'description':
                                              itemDescriptionController.text,
                                          'imageURL': images,
                                          'oldPost': _oldPostInfo,
                                        }),
                                    screen: const UpdatePostTwo(),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                }
                              },
                              child: const Text('Tiếp theo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'itemNameController', itemNameController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'itemDescriptionController', itemDescriptionController));
    properties.add(IterableProperty<Asset>('images', images));
    properties.add(IterableProperty<String>('oldImages', oldImages));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
  }
}

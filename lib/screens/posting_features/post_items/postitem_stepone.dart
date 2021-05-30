import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import 'postitem_steptwo.dart';

class PostItemOne extends StatefulWidget {
  const PostItemOne({
    Key? key,
  }) : super(key: key);

  static const routeName = '/post_item1';

  @override
  _PostItemOneState createState() => _PostItemOneState();
}

class _PostItemOneState extends State<PostItemOne> {
  late File _image = File(
      'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png');

  final picker = ImagePicker();

  Future getImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(
          'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png');
    });
  }

  Widget imageAdded() {
    if (_image.path == '') {
      return Image.network(
        'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
        height: 100,
        width: 100,
      );
    } else {
      return FloatingActionButton(
        heroTag: null,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      );
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();
  late FocusScopeNode node;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemNumberController = TextEditingController();
  TextEditingController itemCountryController = TextEditingController();

  //Add data
  CollectionReference items = FirebaseFirestore.instance
      .collection('thientin')
      .doc('items')
      .collection('item1');
  Future<void> addItems() {
    // Call the user's CollectionReference to add a new user
    return items.add({
      'item_name': itemNameController.text,
      'item_description': itemDescriptionController.text,
      'item_number': itemNumberController.text,
      'item_country': itemCountryController.text
    });
  }


  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the PostItemOne object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Đăng sản phẩm mới',
            style: TextStyle(color: kTextColor)),
      ),
      body: GestureDetector(
        onTap: () {
          node.unfocus();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              Row(
                children: [
                  Expanded(child: imageAdded()),
                  Expanded(child: imageAdded()),
                  Expanded(child: imageAdded()),
                  Expanded(child: imageAdded()),
                ],
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
                      decoration: const InputDecoration(
                        labelText: 'Tên sản phẩm',
                        labelStyle: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(height: 30),
                    FormBuilderTextField(
                      name: 'item_description',
                      controller: itemDescriptionController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Mô tả sản phẩm',
                        labelStyle: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(height: 30),
                    FormBuilderTextField(
                      name: 'item_number',
                      controller: itemNumberController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Số lượng trao đổi',
                        labelStyle: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      keyboardType: TextInputType.number,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    const SizedBox(height: 30),
                    FormBuilderTextField(
                      name: 'item_country',
                      controller: itemCountryController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Xuất xứ',
                        labelStyle: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      onEditingComplete: () => node.unfocus(),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.maxFinite, // set width to maxFinite

                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                kPrimaryLightColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kPrimaryColor)),
                        onPressed: () {
                          node.unfocus();
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            //addItems();
                            pushNewScreenWithRouteSettings<void>(
                              context,
                              settings: RouteSettings(
                                  name: PostItemTwo.routeName,
                                  arguments: {
                                    'item_name': itemNameController.text,
                                    'item_description':
                                        itemDescriptionController.text,
                                    'item_number': itemNumberController.text,
                                    'item_country': itemCountryController.text,
                                  }),
                              screen: const PostItemTwo(),
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
    properties.add(DiagnosticsProperty<ImagePicker>('picker', picker));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'itemNameController', itemNameController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'itemDescriptionController', itemDescriptionController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'itemNumberController', itemNumberController));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'itemCountryController', itemCountryController));
    properties
        .add(DiagnosticsProperty<CollectionReference<Object?>>('items', items));
  }
}

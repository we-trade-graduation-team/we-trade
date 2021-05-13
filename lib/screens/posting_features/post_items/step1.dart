import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../configs/constants/color.dart';
import 'step2.dart';

// Navigator.of(context).pushNamed(PostItem_1.routeName);
//import '../post_items/step1.dart';
//import '../post_items/step2.dart';
// ignore: camel_case_types
class PostItem_1 extends StatefulWidget {
  const PostItem_1({
    Key? key,
  }) : super(key: key);

  static const routeName = '/post_item1';

  @override
  _PostItem_1State createState() => _PostItem_1State();
}

// ignore: camel_case_types
class _PostItem_1State extends State<PostItem_1> {
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
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      );
    }
  }

  late FocusScopeNode node;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the PostItem_1 object that was created by
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
              //nhap thong tin
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Quần, áo, túi xách,...',
                    labelText: 'Tên sản phẩm',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  enabled: true),
              const SizedBox(
                height: 15,
              ),
              //mo ta
              TextFormField(
                  maxLines: null,
                  minLines: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mô tả',
                    //custom height and width
                    hintText: 'Chức năng, giá,...',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  enabled: true),
              const SizedBox(
                height: 15,
              ),
              // so luong
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Số lượng',
                    //custom height and width
                    hintText: '5',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  initialValue: '1',
                  enabled: true),
              const SizedBox(
                height: 15,
              ),
              // xuat xu
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Xuất xứ',
                    //custom height and width
                    hintText: 'Việt Nam',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  enabled: true),
              const SizedBox(
                height: 15,
              ),

              //button
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryLightColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor)),
                onPressed: () {
                  pushNewScreenWithRouteSettings<void>(
                    context,
                    settings: const RouteSettings(name: PostItem_2.routeName),
                    screen: const PostItem_2(),
                    // withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // Navigator.of(context).pushNamed(PostItems2.routeName);
                },
                child: const Text('Tiếp theo'),
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
  }
}

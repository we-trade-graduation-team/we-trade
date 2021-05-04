import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../configs/constants/color.dart';
import 'step2.dart';

class PostItems1Screen extends StatefulWidget {
  const PostItems1Screen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/post_item1';

  @override
  _PostItems1ScreenState createState() => _PostItems1ScreenState();
}

class _PostItems1ScreenState extends State<PostItems1Screen> {
  late FocusScopeNode node;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the PostItems1 object that was created by
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
                  Expanded(
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Expanded(
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
                      height: 100,
                      width: 100,
                    ),
                  )
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
                    settings: const RouteSettings(name: PostItems2.routeName),
                    screen: const PostItems2(),
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
  }
}

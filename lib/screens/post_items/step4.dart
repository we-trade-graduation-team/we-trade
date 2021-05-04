import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/color.dart';
import '../detail_screen/detail.dart';

// ignore: camel_case_types
class PostItem_4 extends StatefulWidget {
  const PostItem_4({Key? key}) : super(key: key);
  static const routeName = '/PostItem_4';

  @override
  _PostItem_4_State createState() => _PostItem_4_State();
}

// ignore: camel_case_types
class _PostItem_4_State extends State<PostItem_4> {
  late FocusScopeNode node;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the Post_Item_1 object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Đăng sản phẩm mới - 4',
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
            children: <Widget>[
              //Thông tin mặc định
              TextFormField(
                  minLines: 5,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText:
                        '227 Nguyễn Văn Cừ, Phường 4, Quận 5, TP Hồ Chí Minh',
                    labelText: 'Địa chỉ (Mặc định) ',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  enabled: false),
              const SizedBox(
                height: 25,
              ),
              //Thành phố
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tỉnh / Thành Phố',
                    //custom height and width
                    hintText: 'TP Hồ Chí Minh',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  enabled: true),
              const SizedBox(
                height: 25,
              ),
              // Quận
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quận / Huyện',
                    //custom height and width
                    hintText: 'Quận 5',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  initialValue: '',
                  enabled: true),
              const SizedBox(
                height: 25,
              ),
              // Phường
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phường / Xã',
                    //custom height and width
                    hintText: 'Phường 4',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  enabled: true),
              const SizedBox(
                height: 25,
              ),
              // Đường
              TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Đường',
                    //custom height and width
                    hintText: '227 Nguyễn Văn Cừ',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  enabled: true),
              const SizedBox(
                height: 25,
              ),
              //button
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryLightColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor)),
                onPressed: () {
                  Navigator.of(context).pushNamed(DetailScreen.routeName);
                },
                child: const Text('Hoàn thành'),
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

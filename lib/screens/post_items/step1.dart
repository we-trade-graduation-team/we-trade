import 'package:flutter/material.dart';

import 'step2.dart';

// Navigator.of(context).pushNamed(PostItems1.routeName);
//import '../post_items/step1.dart';
//import '../post_items/step2.dart';
class PostItems1 extends StatefulWidget {
  const PostItems1({Key? key}) : super(key: key);
  static const routeName = '/postitem1';

  @override
  _PostItems1State createState() => _PostItems1State();
}

class _PostItems1State extends State<PostItems1> {
  void _reset() {
    setState(() {
      //gọi khi có thay đổi
      //FocusScope.of(context).requestFocus(FocusNode()); // tắt bàn phím
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the PostItems1 object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Đăng sản phẩm mới'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
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
                    child: GestureDetector(
                      //thêm event
                      onTap: _reset,
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      //thêm event
                      onTap: _reset,
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      //thêm event
                      onTap: _reset,
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png',
                        height: 100,
                        width: 100,
                      ),
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
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purpleAccent)),
                onPressed: () {
                  Navigator.of(context).pushNamed(PostItems2.routeName);
                },
                child: const Text('Tiếp theo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
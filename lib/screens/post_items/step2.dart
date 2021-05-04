import 'package:flutter/material.dart';
import '../../configs/constants/color.dart';

import 'step3.dart';

// ignore: camel_case_types
class PostItem_2 extends StatefulWidget {
  const PostItem_2({Key? key}) : super(key: key);
  static const routeName = '/postitem2';

  @override
  _PostItem_2_State createState() => _PostItem_2_State();
}

class TypeofGoods {
  final int id;
  final String name;
  bool selected;
  // ignore: sort_constructors_first
  TypeofGoods({required this.id, required this.name, this.selected = false});
}

// ignore: camel_case_types
class _PostItem_2_State extends State<PostItem_2> {
  // ignore: unused_element
  void _reset() {
    setState(() {
      //gọi khi có thay đổi
    });
  }

  List<TypeofGoods> _type = [
    // ignore: prefer_single_quotes
    TypeofGoods(id: 1, name: 'Lion'),
    TypeofGoods(id: 2, name: 'Flamingo'),
    TypeofGoods(id: 3, name: 'Hippo'),
    TypeofGoods(id: 4, name: 'Horse'),
    TypeofGoods(id: 5, name: 'Tiger'),
    TypeofGoods(id: 6, name: 'Penguin'),
    TypeofGoods(id: 7, name: 'Spider'),
    TypeofGoods(id: 8, name: 'Snake'),
    TypeofGoods(id: 9, name: 'Bear'),
    TypeofGoods(id: 10, name: 'Beaver'),
    TypeofGoods(id: 11, name: 'Cat'),
    TypeofGoods(id: 12, name: 'Fish'),
    TypeofGoods(id: 13, name: 'Rabbit'),
    TypeofGoods(id: 14, name: 'Mouse'),
    TypeofGoods(id: 15, name: 'Dog'),
    TypeofGoods(id: 16, name: 'Zebra'),
    TypeofGoods(id: 17, name: 'Cow'),
    TypeofGoods(id: 18, name: 'Frog'),
    TypeofGoods(id: 19, name: 'Blue Jay'),
    TypeofGoods(id: 20, name: 'Moose'),
    TypeofGoods(id: 21, name: 'Gecko'),
    TypeofGoods(id: 22, name: 'Kangaroo'),
    TypeofGoods(id: 23, name: 'Shark'),
    TypeofGoods(id: 24, name: 'Crocodile'),
    TypeofGoods(id: 25, name: 'Owl'),
    TypeofGoods(id: 26, name: 'Dragonfly'),
    TypeofGoods(id: 27, name: 'Dolphin'),
  ];

// ignore: deprecated_member_use
  List<TypeofGoods> _values = [];
  Widget buildChips() {
    // ignore: deprecated_member_use
    final chips = <Widget>[];

    for (var i = 0; i < _type.length; i++) {
      final _item = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ChoiceChip(
          selected: _type[i].selected,
          label: Text(_type[i].name),
          elevation: 3,
          pressElevation: 2,
          shadowColor: Colors.teal,
          onSelected: (_selected) {
            setState(() {
              _type[i].selected = !_type[i].selected;
              if (_type[i].selected == true) {
                // ignore: always_put_control_body_on_new_line
                if (!_values.contains(_type[i])) _values.add(_type[i]);
              } else {
                if (_values.contains(_type[i])) {
                  _values.removeWhere((_items) => _items.id == _type[i].id);
                }
              }
              _values = _values;
            });
          },
        ),
      );

      chips.add(_item);
    }

    return Wrap(
      // This next line does the trick.
      children: chips,
    );
  }

  Widget recordChips() {
    // ignore: deprecated_member_use
    final chips = <Widget>[];

    for (var i = 0; i < _values.length; i++) {
      final _item = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Chip(
          label: Text(_values[i].name),
          elevation: 3,
          shadowColor: Colors.teal,
          onDeleted: () {
            final index =
                _type.indexWhere((element) => element.id == _values[i].id);
            _values.removeAt(i);
            setState(() {
              _type[index].selected = false;
              _values = _values;
              _type = _type;
            });
          },
        ),
      );

      chips.add(_item);
    }

    return Wrap(
      // This next line does the trick.
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Đăng sản phẩm mới - 2',
            style: TextStyle(color: kTextColor)),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Phân loại sản phẩm',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              buildChips(),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Loại sản phẩm',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 240),
                  child: recordChips(),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              SizedBox(
                width: double.maxFinite, // set width to maxFinite
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryLightColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kPrimaryColor)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(PostItem_3.routeName);
                  },
                  child: const Text('Tiếp theo'),
                ),
              ),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

import 'step3.dart';

// ignore: camel_case_types
class PostItem_2 extends StatefulWidget {
  const PostItem_2({Key? key}) : super(key: key);
  static const routeName = '/postitem2';

  @override
  _PostItem_2_State createState() => _PostItem_2_State();
}

class TypeOfGoods {
  TypeOfGoods({required this.id, required this.name, this.selected = false});
  final int id;
  final String name;
  bool selected;
}

// ignore: camel_case_types
class _PostItem_2_State extends State<PostItem_2> {
  // ignore: unused_element
  void _reset() {
    setState(() {
      //gọi khi có thay đổi
    });
  }

  List<TypeOfGoods> _type = [
    TypeOfGoods(id: 1, name: 'Lion'),
    TypeOfGoods(id: 2, name: 'Flamingo'),
    TypeOfGoods(id: 3, name: 'Hippo'),
    TypeOfGoods(id: 4, name: 'Horse'),
    TypeOfGoods(id: 5, name: 'Tiger'),
    TypeOfGoods(id: 6, name: 'Penguin'),
    TypeOfGoods(id: 7, name: 'Spider'),
    TypeOfGoods(id: 8, name: 'Snake'),
    TypeOfGoods(id: 9, name: 'Bear'),
    TypeOfGoods(id: 10, name: 'Beaver'),
    TypeOfGoods(id: 11, name: 'Cat'),
    TypeOfGoods(id: 12, name: 'Fish'),
    TypeOfGoods(id: 13, name: 'Rabbit'),
    TypeOfGoods(id: 14, name: 'Mouse'),
    TypeOfGoods(id: 15, name: 'Dog'),
    TypeOfGoods(id: 16, name: 'Zebra'),
    TypeOfGoods(id: 17, name: 'Cow'),
    TypeOfGoods(id: 18, name: 'Frog'),
    TypeOfGoods(id: 19, name: 'Blue Jay'),
    TypeOfGoods(id: 20, name: 'Moose'),
    TypeOfGoods(id: 21, name: 'Gecko'),
    TypeOfGoods(id: 22, name: 'Kangaroo'),
    TypeOfGoods(id: 23, name: 'Shark'),
    TypeOfGoods(id: 24, name: 'Crocodile'),
    TypeOfGoods(id: 25, name: 'Owl'),
    TypeOfGoods(id: 26, name: 'Dragonfly'),
    TypeOfGoods(id: 27, name: 'Dolphin'),
  ];

  List<TypeOfGoods> _values = [];
  Widget buildChips() {
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
                if (!_values.contains(_type[i])) {
                  _values.add(_type[i]);
                }
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

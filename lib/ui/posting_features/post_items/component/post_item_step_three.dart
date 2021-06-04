import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:we_trade/constants/app_colors.dart';

import 'post_item_step_four.dart';

class PostItemThree extends StatefulWidget {
  const PostItemThree({Key? key}) : super(key: key);
  static const routeName = '/postitem3';

  @override
  _PostItemThreeState createState() => _PostItemThreeState();
}

class TypeofGoods {
  TypeofGoods({required this.id, required this.name, this.selected = false});
  final int id;
  bool selected;
  final String name;
}

List<TypeofGoods> _type = <TypeofGoods>[];
List<TypeofGoods> _values = [];
Future<bool> getData() async {
  final CollectionReference category = FirebaseFirestore.instance
      .collection('thientin')
      .doc('category')
      .collection('categoryList');
  await category.get().then((categoryType) {
    var index = 1;
    for (final type in categoryType.docs) {
      final tempType =
          TypeofGoods(id: index, name: type['category_name'].toString());
      if (_type.any((element) => element.id == tempType.id)) {
        index++;
      } else {
        _type.add(tempType);
        index++;
      }
      index++;
    }

    return true;
  });
  return false;
}

class _PostItemThreeState extends State<PostItemThree> {
  Widget buildChips(List<TypeofGoods> _type) {
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

  Widget recordChips(List<TypeofGoods> _type, List<TypeofGoods> _values) {
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

  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    getData().then((value) => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Đăng sản phẩm mới - 3',
            style: TextStyle(color: AppColors.kTextColor)),
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
                        child: Text('Chọn loại sản phẩm muốn đổi',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    buildChips(_type),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Loại sản phẩm muốn đổi: ',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 240),
                        child: recordChips(_type, _values),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite, // set width to maxFinite
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColors.kPrimaryLightColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.kScreenBackgroundColor)),
                        onPressed: () {
                          pushNewScreenWithRouteSettings<void>(
                            context,
                            settings: const RouteSettings(
                                name: PostItemFour.routeName),
                            screen: PostItemFour(),
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
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:group_button/group_button.dart';
class FilterOverlay extends StatefulWidget {
  const FilterOverlay({Key? key}):super(key:key);
  static String routeName='/filterOverlay';
  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  ProductKind chosenKind = const ProductKind(name: 'Tất cả');
  Province chosenProvince = const Province(name: 'Tất cả');
  District chosenDistrict = const District(name: 'Tất cả');

  final List<ProductKind> productKinds=<ProductKind>[const ProductKind(name: 'Tất cả'),const ProductKind(name: 'Điện thoại'),const ProductKind(name: 'QUần áo')];
  final List<Province> provinces=<Province>[const Province(name: 'Tất cả'),const Province(name: 'Hà Nội'),const Province(name: 'TP. Hồ Chí Minh')];
  final List<District> districts=<District>[const District(name: 'Tất cả'),const District(name: 'Quận 1'),const District(name: 'Quận 2')];

  List<String> costs=['Tất cả', 'Dưới 100.000','Từ 100.000 đến 500.000','Từ 500.000 đến 1000.000',
                      'Từ 1000.000 đến 5000.000','Từ 5000.000 đến 10.000.000', 'Trên 10.000.000'];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    const Text(
                      'Loại mặt hàng:',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    DropdownButton<ProductKind>(
                      focusColor: Colors.grey,
                      isExpanded: true,
                      iconEnabledColor: const Color(0xFF6F35A5),
                      hint: const Text('Tất cả'),
                      value: chosenKind,
                      items: productKinds.map((kind){
                        return DropdownMenuItem<ProductKind>(
                          value: kind,
                          child: Text(kind.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          chosenKind = value!;
                        });
                      },
                    ),
                   ],
                ),
                const TableRow(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    SizedBox(height: 10,)
                  ]
                ),
                TableRow(
                  children: <Widget>[
                    const Text(
                      'Nơi bán:',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Container(),
                  ]
                ),
                const TableRow(
                  children: <Widget>[
                    SizedBox(height: 5,),
                    SizedBox(height: 5,)
                  ]
                ),
                TableRow(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const Text(
                              'Tỉnh/Thành phố:',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    DropdownButton<Province>(
                      isExpanded: true,
                      iconEnabledColor: const Color(0xFF6F35A5),
                      hint: const Text('Tất cả'),
                      value: chosenProvince,
                      items: provinces.map((province){
                        return DropdownMenuItem<Province>(
                          value: province,
                          child: Text(province.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          chosenProvince = value!;
                        });
                      },
                    )
                  ]
                ),
                const TableRow(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    SizedBox(height: 10,)
                  ]
                ),
                TableRow(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              'Quận/Huyện:',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    DropdownButton<District>(
                      isExpanded: true,
                      iconEnabledColor: const Color(0xFF6F35A5),
                      hint: const Text('Tất cả'),
                      value: chosenDistrict,
                      items: districts.map((district){
                        return DropdownMenuItem<District>(
                          value: district,
                          child: Text(district.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          chosenDistrict = value!;
                        });
                      },
                    )
                  ]
                )
              ]
            ),
            const SizedBox(height: 10,),
            GroupButton(
              
              selectedColor: const Color(0xFF6F35A5),
              buttons: costs,
              spacing: 10,
              onSelected: (index,isSelected){}
            )
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('costs', costs));
    properties.add(IterableProperty<Province>('provinces', provinces));
    properties.add(IterableProperty<ProductKind>('productKinds', productKinds));
    properties.add(IterableProperty<District>('districts', districts));
    properties.add(DiagnosticsProperty<District>('chosenDistrict', chosenDistrict));
    properties.add(DiagnosticsProperty<ProductKind>('chosenKind', chosenKind));
    properties.add(DiagnosticsProperty<Province>('chosenProvince', chosenProvince));
  }
}

class ProductKind{
  const ProductKind({
    required this.name
  });
  final String name;
}
class Province{
  const Province({
    required this.name
  });
  final String name;
}
class District{
  const District({
    required this.name
  });
  final String name;
}

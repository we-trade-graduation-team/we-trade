import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
class FilterOverlay extends StatefulWidget {
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Loại mặt hàng:',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(width: 10.0,),
                DropdownButton<ProductKind>(
                  hint: Text('Tất cả'),
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
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Text(
              'Nơi bán:',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        'Tỉnh/Thành phố:',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      DropdownButton<Province>(
                        hint: Text('Tất cả'),
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
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      Text(
                        'Quận/Huyện:',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      DropdownButton<District>(
                        hint: Text('Tất cả'),
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
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            GroupButton(
              isRadio: true,
              buttons: costs,
              spacing: 10,
              onSelected: (index,isSelected){}
            )
          ],
        ),
      ),
    );
  }
}

class ProductKind{
  final String name;
  const ProductKind({required this.name});
}
class Province{
  final String name;
  const Province({required this.name});
}
class District{
  final String name;
  const District({required this.name});
}

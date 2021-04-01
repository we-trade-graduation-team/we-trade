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
                ),
                      ),
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

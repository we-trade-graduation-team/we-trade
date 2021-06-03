import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:group_button/group_button.dart';

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({
    Key? key,
  }) : super(key: key);

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  ProductKind _chosenKind = const ProductKind(name: 'Tất cả');
  Province _chosenProvince = const Province(name: 'Tất cả');
  District _chosenDistrict = const District(name: 'Tất cả');

  @override
  Widget build(BuildContext context) {
    final productKinds = [
      const ProductKind(name: 'Tất cả'),
      const ProductKind(name: 'Điện thoại'),
      const ProductKind(name: 'QUần áo')
    ];
    final provinces = [
      const Province(name: 'Tất cả'),
      const Province(name: 'Hà Nội'),
      const Province(name: 'TP. Hồ Chí Minh')
    ];
    final districts = [
      const District(name: 'Tất cả'),
      const District(name: 'Quận 1'),
      const District(name: 'Quận 2')
    ];

    final costs = [
      'Tất cả',
      'Dưới 100.000',
      'Từ 100.000 đến 500.000',
      'Từ 500.000 đến 1000.000',
      'Từ 1000.000 đến 5000.000',
      'Từ 5000.000 đến 10.000.000',
      'Trên 10.000.000'
    ];
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Table(
          children: [
            TableRow(children: [
              Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        const Text(
                          'Loại mặt hàng:',
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButton<ProductKind>(
                          focusColor: Colors.grey,
                          isExpanded: true,
                          iconEnabledColor: const Color(0xFF6F35A5),
                          hint: const Text('Tất cả'),
                          value: _chosenKind,
                          items: productKinds.map((kind) {
                            return DropdownMenuItem<ProductKind>(
                              value: kind,
                              child: Text(kind.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chosenKind = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const TableRow(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ]),
                    TableRow(children: [
                      const Text(
                        'Nơi bán:',
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(),
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ]),
                    TableRow(children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              AutoSizeText(
                                'Tỉnh/Thành phố:',
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      DropdownButton<Province>(
                        isExpanded: true,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        hint: const Text('Tất cả'),
                        value: _chosenProvince,
                        items: provinces.map((province) {
                          return DropdownMenuItem<Province>(
                            value: province,
                            child: Text(province.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenProvince = value!;
                          });
                        },
                      )
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ]),
                    TableRow(children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              AutoSizeText(
                                'Quận/Huyện:',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      DropdownButton<District>(
                        isExpanded: true,
                        iconEnabledColor: const Color(0xFF6F35A5),
                        hint: const Text('Tất cả'),
                        value: _chosenDistrict,
                        items: districts.map((district) {
                          return DropdownMenuItem<District>(
                            value: district,
                            child: Text(district.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenDistrict = value!;
                          });
                        },
                      )
                    ])
                  ]),
            ]),
            const TableRow(children: [
              SizedBox(
                height: 10,
              ),
            ]),
            const TableRow(children: [
              SizedBox(
                height: 10,
              ),
            ]),
            TableRow(
              children: [
                GroupButton(
                    selectedColor: const Color(0xFF6F35A5),
                    buttons: costs,
                    spacing: 10,
                    onSelected: (index, isSelected) {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductKind {
  const ProductKind({required this.name});
  final String name;
}

class Province {
  const Province({required this.name});
  final String name;
}

class District {
  const District({required this.name});
  final String name;
}

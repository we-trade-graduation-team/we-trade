import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../../../services/post_feature/post_service_firestore.dart';
import '../../../posting_features/component/class.dart';

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({
    Key? key,
  }) : super(key: key);

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  PostServiceFireStore dataServiceFireStore = PostServiceFireStore();
  List<Cities> citiesList = [];
  List<Cities> districtList = [];
  Cities citySelected = Cities(id: 'init', name: 'init');
  Cities districtSelected = Cities(id: 'init', name: 'init');
  String previousID = '';
  late TypeofGoods mainCategory = TypeofGoods(id: '', name: '');
  final List<TypeofGoods> _type = [];
  bool isLoading = true;

  Future<List<Cities>> getCities() {
    final _tempCities = <Cities>[];
    return dataServiceFireStore.getCities().then((value) {
      for (final item in value.docs) {
        final tempCity =
            Cities(id: item.id, name: item.data()['city'].toString());
        _tempCities.add(tempCity);
      }
      return _tempCities;
    });
  }

  Future<List<Cities>> getDistrict(String city) {
    final _typeSubTemp = <Cities>[];
    return dataServiceFireStore.getDistrict(city).then((value) {
      for (final item in value.docs) {
        final subCate =
            Cities(id: item.id, name: item.data()['district'].toString());
        _typeSubTemp.add(subCate);
      }
      return _typeSubTemp;
    });
  }

  Future<List<TypeofGoods>> getMainCategoryData() {
    final _tempCategory = <TypeofGoods>[];
    return dataServiceFireStore.getMainCategory().then((value) {
      for (final item in value.docs) {
        final itemCate =
            TypeofGoods(id: item.id, name: item.data()['category'].toString());
        _tempCategory.add(itemCate);
      }
      return _tempCategory;
    });
  }

  @override
  void initState() {
    super.initState();
    getCities().then((value) {
      citiesList = value;
      citySelected = value.first;
    }).whenComplete(() => setState(() {}));
  }

  Widget citiesDropDown() {
    return DropdownButton<Cities>(
      value: citiesList.isNotEmpty ? citySelected : null,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newValue) {
        setState(() {
          citySelected = newValue!;
        });
      },
      items: citiesList.isNotEmpty
          ? citiesList.map<DropdownMenuItem<Cities>>((value) {
              return DropdownMenuItem<Cities>(
                value: value,
                child: Text(value.name),
              );
            }).toList()
          : [],
    );
  }

  Widget districtDropDown() => DropdownButton<Cities>(
        value: districtList.isNotEmpty ? districtSelected : null,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (newValue) {
          setState(() {
            districtSelected = newValue!;
          });
        },
        items: districtList.isNotEmpty
            ? districtList.map<DropdownMenuItem<Cities>>((value) {
                return DropdownMenuItem<Cities>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList()
            : [],
      );

  Widget categoryDropDown() => DropdownButton<TypeofGoods>(
        value: _type.isNotEmpty ? mainCategory : null,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        isExpanded: true,
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (newValue) {
          setState(() {
            mainCategory = newValue!;
            isLoading = true; //thành loading
          });
        },
        items: _type.isNotEmpty
            ? _type.map<DropdownMenuItem<TypeofGoods>>((value) {
                return DropdownMenuItem<TypeofGoods>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList()
            : [],
      );
  @override
  Widget build(BuildContext context) {
    if (citySelected.id == 'init' || citySelected.id == previousID) {
      //no run getSub when setState
    } else {
      getDistrict(citySelected.name).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            districtList = value;
            districtSelected = value.first;
            previousID = citySelected.id;
            isLoading = false;
          });
        } else {
          setState(() {
            districtList = [];
            previousID = citySelected.id;
            isLoading = false;
          });
        }
      });
    }
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
                        if (mainCategory.id != '')
                          categoryDropDown()
                        else
                          Container(),
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
                      citiesDropDown(),
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
                      districtDropDown()
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
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PostServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
    properties.add(IterableProperty<Cities>('citiesList', citiesList));
    properties.add(IterableProperty<Cities>('districtList', districtList));
    properties.add(DiagnosticsProperty<Cities>('citySelected', citySelected));
    properties
        .add(DiagnosticsProperty<Cities>('districtSelected', districtSelected));
    properties.add(StringProperty('previousID', previousID));
    properties
        .add(DiagnosticsProperty<TypeofGoods>('mainCategory', mainCategory));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
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

import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../services/post_feature/post_service_algolia.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import '../../../widgets/item_post_card.dart';
import '../../message_features/const_string/const_str.dart';
import '../../posting_features/component/class.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.cateId}) : super(key: key);
  static String routeName = '/search_screen';

  final String? cateId;

  @override
  _SearchScreenState createState() => _SearchScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('cateId', cateId));
  }
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();
  PostServiceAlgolia serviceAlgolia = PostServiceAlgolia();
  PostServiceFireStore serviceFireStore = PostServiceFireStore();
  List<PostCard> posts = [];
  bool isLoading = true;
  bool isGetInitData = true;
  // categories
  late TypeofGoods selectedCategory = TypeofGoods(id: '', name: '');
  List<TypeofGoods> categories = [];
  //adress city and districts
  List<Cities> cities = [];
  Cities selectedCity = Cities(id: 'init', name: 'init');
  //Conditions
  List<Conditions> conditions = [];
  late Conditions selectedCondtion = Conditions(description: '', priority: 0);

  // funtcion future ... ==============================
  Future<List<TypeofGoods>> getMainCategoryData() {
    // get main categories
    final _tempCategory = <TypeofGoods>[];
    return serviceFireStore.getMainCategory().then((value) {
      for (final item in value.docs) {
        final itemCate =
            TypeofGoods(id: item.id, name: item.data()['category'].toString());
        _tempCategory.add(itemCate);
      }
      return _tempCategory;
    });
  }

  Future<List<Cities>> getCities() {
    final _tempCities = <Cities>[];
    return serviceFireStore.getCities().then((value) {
      for (final item in value.docs) {
        final tempCity =
            Cities(id: item.id, name: item.data()['city'].toString());
        _tempCities.add(tempCity);
      }
      return _tempCities;
    });
  }

  Future<List<Conditions>> getConditions() {
    final _typeSubTemp = <Conditions>[];
    return serviceFireStore.getCondition().then((value) {
      for (final item in value.docs) {
        final subCate = Conditions(
            priority: item.data()['priority'] as int,
            description: item.data()['description'].toString());
        _typeSubTemp.add(subCate);
      }
      return _typeSubTemp;
    });
  }

  void initSelectedFilter() {
    setState(() {
      selectedCategory = categories.last;
      selectedCondtion = conditions.last;
      selectedCity = cities.last;
    });
  }

  // widget ====================================
  void initiateSearch() {
    setState(() {
      isLoading = true;
    });
    var cateId = '', city = '', condition = '';
    if (selectedCategory.id.isNotEmpty) {
      cateId = selectedCategory.id;
    }
    if (selectedCity.id.isNotEmpty) {
      city = selectedCity.name;
    }
    if (selectedCondtion.priority != 0) {
      condition = selectedCondtion.description;
    }
    serviceAlgolia
        .searchPostCard(searchTextController.text, cateId, city, condition)
        .then((listId) {
      final _firestoreDatabase = context.read<FirestoreDatabase>();
      _firestoreDatabase
          .getPostCardsByPostIdList(postIdList: listId)
          .then((value) => setState(() {
                posts = value;
                isLoading = false;
              }));
    });
  }

  Widget buildFilterWidget() {
    return ConfigurableExpansionTile(
      header: buildHeaderExpansionWidget(isOpen: true),
      headerExpanded: buildHeaderExpansionWidget(isOpen: false),
      children: [buildFilterContentWidget()],
    );
  }

  Widget buildHeaderExpansionWidget({required bool isOpen}) {
    if (isOpen) {
      return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                ),
              ]),
          child: const Icon(
            LineIcons.filter,
            color: Colors.purple,
            size: 30,
          ));
    } else {
      return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                ),
              ]),
          child: const Icon(
            LineIcons.times,
            color: Colors.purple,
            size: 30,
          ));
    }
  }

  Widget buildFilterContentWidget() {
    final primaryColor = Theme.of(context).primaryColor;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          blurRadius: 5,
        ),
      ]),
      padding: const EdgeInsets.all(10),
      width: width,
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                  flex: 3,
                  child: Center(
                    child: Text('Tình trạng ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
              Expanded(flex: 4, child: condtionDropDown()),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Expanded(
                  flex: 3,
                  child: Center(
                      child: Text('danh mục ',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(flex: 4, child: categoryDropDown()),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Expanded(
                  flex: 3,
                  child: Center(
                      child: Text('Thành phố ',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(flex: 4, child: citiesDropDown()),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            const SizedBox(width: 20),
            TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: BorderSide(color: primaryColor)))),
                onPressed: initSelectedFilter,
                child: const Text('Hủy filter')),
          ])
        ],
      ),
    );
  }

  // component widget  ================================
  Widget condtionDropDown() => DropdownButton<Conditions>(
        value: conditions.isNotEmpty ? selectedCondtion : null,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.purple,
        ),
        elevation: 16,
        isExpanded: true,
        hint: const Text('Tình trạng'),
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 1,
          color: Colors.deepPurple.shade200,
        ),
        onChanged: (newValue) {
          setState(() {
            selectedCondtion = newValue!;
          });
        },
        items: conditions.isNotEmpty
            ? conditions.map<DropdownMenuItem<Conditions>>((value) {
                return DropdownMenuItem<Conditions>(
                  value: value,
                  child: Center(
                    child: Text(value.description),
                  ),
                );
              }).toList()
            : [],
      );

  Widget citiesDropDown() => DropdownButton<Cities>(
        value: cities.isNotEmpty ? selectedCity : null,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.purple,
        ),
        elevation: 16,
        isExpanded: true,
        hint: const Text('Thành phố/tỉnh'),
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 1,
          color: Colors.deepPurple.shade200,
        ),
        onChanged: (newValue) {
          setState(() {
            selectedCity = newValue!;
          });
        },
        items: cities.isNotEmpty
            ? cities.map<DropdownMenuItem<Cities>>((value) {
                return DropdownMenuItem<Cities>(
                  value: value,
                  child: Center(child: Text(value.name)),
                );
              }).toList()
            : [],
      );

  Widget categoryDropDown() => DropdownButton<TypeofGoods>(
        value: categories.isNotEmpty ? selectedCategory : null,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.purple,
        ),
        elevation: 16,
        isExpanded: true,
        hint: const Text('Danh mục'),
        style: const TextStyle(color: Colors.black87),
        underline: Container(
          height: 1,
          color: Colors.deepPurple.shade200,
        ),
        onChanged: (newValue) {
          setState(() {
            selectedCategory = newValue!;
          });
        },
        items: categories.isNotEmpty
            ? categories.map<DropdownMenuItem<TypeofGoods>>((value) {
                return DropdownMenuItem<TypeofGoods>(
                  value: value,
                  child: Center(child: Text(value.name)),
                );
              }).toList()
            : [],
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMainCategoryData().then((resultCategories) {
      getCities().then((resultCities) {
        getConditions().then((resultConditions) {
          setState(() {
            resultCategories.add(TypeofGoods(id: '', name: 'Tất cả'));
            categories = resultCategories;
            selectedCategory = resultCategories.last;
            resultCities.add(Cities(id: '', name: 'Tất cả'));
            cities = resultCities;
            selectedCity = resultCities.last;
            resultConditions
                .add(Conditions(description: 'Tất cả', priority: 0));
            conditions = resultConditions;
            selectedCondtion = resultConditions.last;
            isGetInitData = false;
          });
          if (widget.cateId != null) {
            setState(() {
              selectedCategory = resultCategories
                  .firstWhere((element) => element.id == widget.cateId);
            });
            initiateSearch();
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Search here ...',
                      border: InputBorder.none,
                      helperMaxLines: 1,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.kTextLightColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: initiateSearch,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: isGetInitData
              ? Center(
                  child: Column(
                    children: [
                      Lottie.network(
                        messageLoadingStr2,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 20),
                      const Text(loadingDataStr),
                    ],
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: posts.isNotEmpty
                                  ? !isLoading
                                      ? Wrap(
                                          spacing: 20,
                                          runSpacing: 15,
                                          children: posts
                                              .map(
                                                (post) => ItemPostCard(
                                                    postCard: post),
                                              )
                                              .toList(),
                                        )
                                      : Center(
                                          child: Column(
                                            children: [
                                              Lottie.network(
                                                messageLoadingStr2,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fill,
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(loadingDataStr),
                                            ],
                                          ),
                                        )
                                  : const Center(
                                      child: Text('no data'),
                                    ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: buildFilterWidget(),
                      )
                    ],
                  ),
                ),
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PostServiceAlgolia>(
        'serviceAlgolia', serviceAlgolia));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(IterableProperty<PostCard>('posts', posts));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'searchTextController', searchTextController));
    properties.add(DiagnosticsProperty<bool>('isGetInitData', isGetInitData));
    properties.add(
        DiagnosticsProperty<TypeofGoods>('selectedCategory', selectedCategory));
    properties.add(IterableProperty<TypeofGoods>('categories', categories));
    properties.add(IterableProperty<Cities>('cities', cities));
    properties.add(DiagnosticsProperty<Cities>('selectedCity', selectedCity));
    properties.add(IterableProperty<Conditions>('conditions', conditions));
    properties.add(DiagnosticsProperty<PostServiceFireStore>(
        'serviceFireStore', serviceFireStore));
    properties.add(
        DiagnosticsProperty<Conditions>('selectedCondtion', selectedCondtion));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import 'package:we_trade/models/post/post.dart';

import './component/class.dart';
// ignore: directives_ordering
import '../../../../constants/app_colors.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../services/post_feature/post_service_algolia.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import '../../../utils/helper/image_data_storage_helper/image_data_storage_helper.dart';
import 'post_item_step_one.dart';

class PostItemFour extends StatefulWidget {
  const PostItemFour({Key? key}) : super(key: key);
  static const routeName = '/PostItemFour';
  @override
  _PostItemFourState createState() => _PostItemFourState();
}

class _PostItemFourState extends State<PostItemFour> {
  late User thisUser = Provider.of<User?>(context, listen: false)!;

  bool isLoading = true;
  late FocusScopeNode node;
  PostServiceFireStore dataServiceFireStore = PostServiceFireStore();
  PostServiceAlgolia dataServiceAlgolia = PostServiceAlgolia();
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController addressController = TextEditingController();

  //PostCard
  Map post = <String, dynamic>{};

  Map postCard = <String, dynamic>{};
  String postCardImage = '';

  //Address
  List<Cities> citiesList = [];
  List<Cities> districtList = [];
  Cities citySelected = Cities(id: 'init', name: 'init');
  Cities districtSelected = Cities(id: 'init', name: 'init');
  String previousID = '';

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

  Future<bool> updatePost(Map<dynamic, dynamic> arguments) async {
    try {
      final address = <String, dynamic>{};
      address['city'] = citySelected.name;
      address['district'] = districtSelected.name;
      address['address'] = addressController.text
          .replaceAll('  ', ' ')
          .replaceAll(',,', ',')
          .replaceAll('.', ',');
      //item
      final item = <String, dynamic>{};
      item['description'] = arguments['description'];
      item['condition'] = arguments['condition'];
      item['keyword'] = arguments['keyword'];
      item['address'] = address;

      //Category
      final categoryMap = <String, dynamic>{};
      categoryMap['mainCategoryId'] = arguments['mainCategoryId'];
      categoryMap['subCategoryId'] = arguments['subCategoryId'];
      //post
      post['name'] = arguments['name'];
      post['item'] = item;
      post['ownerId'] = thisUser.uid;
      post['category'] = categoryMap;
      post['tradeForListId'] = arguments['tradeForListId'];
      post['isHidden'] = false;
      post['creatAt'] = DateTime.now();
      post['price'] = arguments['price'];
      final tempImageURL = <String>[];
      for (final image in arguments['imagesUrl'] as List<Asset>) {
        await ImageDataStorageHelper.getImageURL(
                thisUser.uid.toString(),
                '${arguments['name']}_${DateTime.now().millisecondsSinceEpoch}',
                image)
            .then(tempImageURL
                .add); //lưu ảnh lên fire storage và trả về list imageURL
      }
      post['imagesUrl'] = tempImageURL;
      postCardImage = tempImageURL.first;

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePostCard(Map<dynamic, dynamic> arguments) async {
    try {
      //item
      final item = <dynamic, dynamic>{};
      item['condition'] = arguments['condition'];
      item['price'] = arguments['price'];
      item['district'] = districtSelected.name;
      item['image'] = postCardImage;
      //postCard
      postCard['item'] = item;
      postCard['title'] = arguments['name'];
      postCard['view'] = 0;
      return true;
    } catch (e) {
      rethrow;
    }
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
  void _showMessgage() {
    showDialog<dynamic>(
      context: context,
      builder: (arlertContext) {
        return AlertDialog(
          //title: const Text(''),
          content: const Text('Đăng sản phẩm thành công'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              onPressed: () {
                Navigator.of(arlertContext).pop();
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute(builder: (context) => const PostItemOne()),
                  (route) => false,
                );
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  void _onLoading(Map<dynamic, dynamic> arguments) {
    updatePost(arguments).then((value) {
      if (value) {
        dataServiceFireStore.addPost(post).then((postID) {
          updatePostCard(arguments).then((value) {
            if (value) {
              dataServiceFireStore.addPostCard(postCard, postID);
              dataServiceFireStore.addJunctionKeywordPost(
                  arguments['keywordId'] as List<String>, postID);
            }
          });

          dataServiceAlgolia.addPost(
              objectID: postID,
              name: arguments['name'] as String,
              mainCategoyId: arguments['mainCategoryId'] as int,
              subCategoryId: arguments['subCategoryId'] as int,
              tradeForListId: arguments['tradeForListId'] as List<int>,
              imageURL: post['imagesUrl'][0] as String,
              condition: arguments['condition'] as String,
              price: arguments['price'] as int,
              district: districtSelected.name);
        });
      } else {}
    }).whenComplete(_showMessgage);
  }

  @override
  void initState() {
    super.initState();
    getCities().then((value) {
      citiesList = value;
      citySelected = value.first;
    }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    node = FocusScope.of(context);
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
    return Scaffold(
      backgroundColor: AppColors.kScreenBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Tạo bài đăng mới - 4'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: node.unfocus,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    //Thành phố
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Khu vực giao dịch',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const Text('Tỉnh / Thành phố'),
                    citiesDropDown(),
                    const SizedBox(
                      height: 25,
                    ),
                    // Quận
                    const Text('Quận / Huyện'),
                    districtDropDown(),
                    const SizedBox(
                      height: 25,
                    ),
                    // Đường
                    FormBuilder(
                      key: _formKey,
                      onChanged: () {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'address',
                            controller: addressController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              labelText: 'Đường - Phường/Xã',
                              labelStyle: TextStyle(
                                color: AppColors.kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.minLength(context, 5),
                            ]),
                            onEditingComplete: () => node.unfocus(),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.maxFinite, // set width to maxFinite
                            child: TextButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.kPrimaryLightColor),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor)),
                              onPressed: () {
                                if (_formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  setState(() {
                                    _onLoading(arguments);
                                    isLoading = true;
                                  });
                                }
                              },
                              child: const Text('Đăng sản phẩm'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
    properties.add(DiagnosticsProperty<PostServiceFireStore>(
        'dataServiceFireStore', dataServiceFireStore));
    properties.add(IterableProperty<Cities>('citiesList', citiesList));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
    properties.add(DiagnosticsProperty<Cities>('citySelected', citySelected));
    properties.add(StringProperty('previousID', previousID));
    properties
        .add(DiagnosticsProperty<Cities>('districtSelected', districtSelected));
    properties.add(DiagnosticsProperty<TextEditingController>(
        'addressController', addressController));
    properties.add(IterableProperty<Cities>('districtList', districtList));
    properties.add(DiagnosticsProperty<User>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<Map>('postCard', postCard));
    properties.add(DiagnosticsProperty<Map>('post', post));
    properties.add(StringProperty('postCardImage', postCardImage));
    properties.add(DiagnosticsProperty<PostServiceAlgolia>(
        'dataServiceAlgolia', dataServiceAlgolia));
  }
}

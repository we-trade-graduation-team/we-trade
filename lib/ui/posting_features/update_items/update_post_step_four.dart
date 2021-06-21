import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';

import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../services/post_feature/post_service_algolia.dart';
import '../../../services/post_feature/post_service_firestore.dart';
import '../../../utils/helper/image_data_storage_helper/image_data_storage_helper.dart';
import '../component/class.dart';

class UpdatePostFour extends StatefulWidget {
  const UpdatePostFour({Key? key}) : super(key: key);
  static const routeName = '/UpdatePostFour';
  @override
  _UpdatePostFourState createState() => _UpdatePostFourState();
}

class _UpdatePostFourState extends State<UpdatePostFour> {
  late User thisUser = Provider.of<User?>(context, listen: false)!;
  late Post _oldPostInfo;

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

  // Future<void> _setPostDetails(String postId) async {
  //   try {
  //     final _firebaseDatabase = context.read<FirestoreDatabase>();
  //     await _firebaseDatabase.setPostDetails(postId: postId);
  //   } catch (err) {
  //     log(err.toString());
  //   }
  // }

  Future<PostCard> getPostCard(String postId) async {
    try {
      final _firebaseDatabase = context.read<FirestoreDatabase>();
      final _postCardInfo = await _firebaseDatabase.getPostCard(postId: postId);
      return _postCardInfo;
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  Future<bool> updatePost(Map<dynamic, dynamic> arguments) async {
    try {
      final addressInfo = <String, dynamic>{};
      addressInfo['city'] = citySelected.name;
      addressInfo['district'] = districtSelected.name;
      addressInfo['address'] = addressController.text
          .replaceAll('  ', ' ')
          .replaceAll(',,', ',')
          .replaceAll('.', ',');
      //item
      final itemInfo = <String, dynamic>{};
      itemInfo['description'] = arguments['description'];
      itemInfo['condition'] = arguments['condition'];
      itemInfo['keywords'] = arguments['keyword'];
      itemInfo['addressInfo'] = addressInfo;

      //Category
      final categoryInfo = <String, dynamic>{};
      categoryInfo['mainCategoryId'] = arguments['mainCategoryId'];
      categoryInfo['subCategoryId'] = arguments['subCategoryId'];
      //post
      post['name'] = arguments['name'];
      post['itemInfo'] = itemInfo;
      post['owner'] = _oldPostInfo.owner;
      post['categoryInfo'] = categoryInfo;
      post['tradeForList'] = arguments['tradeForList'];
      post['isHidden'] = _oldPostInfo.isHidden;
      post['createAt'] = DateTime.now();
      post['price'] = arguments['price'];
      var tempImageURL = <String>[];
      final imagesTemp = arguments['imagesUrl'] as List<Asset>;
      if (imagesTemp.isEmpty) {
        tempImageURL = _oldPostInfo.imagesUrl;
      } else {
        for (final image in arguments['imagesUrl'] as List<Asset>) {
          await ImageDataStorageHelper.getImageURL(
                  thisUser.uid.toString(),
                  '${arguments['name']}_${DateTime.now().millisecondsSinceEpoch}',
                  image)
              .then(tempImageURL
                  .add); //lưu ảnh lên fire storage và trả về list imageURL
        }
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
      await getPostCard(_oldPostInfo.postId!).then((value) {
        final item = <dynamic, dynamic>{};
        item['condition'] = arguments['condition'];
        item['price'] = arguments['price'];
        item['district'] = districtSelected.name;
        item['image'] = postCardImage;
        //postCard
        postCard['item'] = item;
        postCard['title'] = arguments['name'];
        postCard['view'] = value.view;
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }

  void _onLoading(Map<dynamic, dynamic> arguments) {
    updatePost(arguments).then((value) {
      if (value) {
        dataServiceFireStore
            .updatePost(post, _oldPostInfo.postId!)
            .then((value) {
          // dataServiceFireStore.addPostUser(
          //     thisUserId: thisUser.uid!, postId: _oldPostInfo.postId!);
          updatePostCard(arguments).then((value) {
            if (value) {
              dataServiceFireStore
                  .addPostCard(postCard, _oldPostInfo.postId!)
                  .whenComplete(() {
                //_setPostDetails(_oldPostInfo.postId!);
              });
              dataServiceFireStore
                  .deleteJunctionKeywordPost(_oldPostInfo.postId!)
                  .whenComplete(() {
                dataServiceFireStore.addJunctionKeywordPost(
                    arguments['keywordId'] as List<String>,
                    _oldPostInfo.postId!);
              });
            }
          });

          dataServiceAlgolia.updatePost(
              objectID: _oldPostInfo.postId!,
              name: arguments['name'] as String,
              mainCategoyId: arguments['mainCategoryId'] as String,
              subCategoryId: arguments['subCategoryId'] as String,
              tradeForList: arguments['tradeForList'] as List<String>,
              condition: arguments['condition'] as String,
              price: arguments['price'] as int,
              district: districtSelected.name,
              city: citySelected.name);
        });
      } else {}
    }).whenComplete(_showCompleteStatus);
  }

  void _showCompleteStatus() {
    showDialog<dynamic>(
      context: context,
      builder: (arlertContext) {
        return AlertDialog(
          content: const Text('Cập nhật thông tin sản phẩm thành công'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(arlertContext).pop();
                Navigator.popUntil(context, ModalRoute.withName('/'));
                // Navigator.pushAndRemoveUntil<void>(
                //   context,
                //   MaterialPageRoute(builder: (context) => const PostItemOne()),
                //   (route) => false,
                // );
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCities().then((value) {
      citiesList = value;
      citySelected = value.firstWhere(
          (element) => element.name == _oldPostInfo.itemInfo.addressInfo.city);
      addressController.text = _oldPostInfo.itemInfo.addressInfo.address;
    }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _oldPostInfo = arguments['oldPost'] as Post;

    node = FocusScope.of(context);
    if (citySelected.id == 'init' || citySelected.id == previousID) {
      //no run getSub when setState
    } else {
      getDistrict(citySelected.name).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            districtList = value;
            if (_oldPostInfo.itemInfo.addressInfo.city == citySelected.name) {
              districtSelected = value.firstWhere((element) =>
                  element.name == _oldPostInfo.itemInfo.addressInfo.district);
            } else {
              districtSelected = value.first;
            }
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
        title: const Text('Chỉnh sửa bài đăng - 4'),
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
                    const SizedBox(
                      height: 10,
                    ),
                    //Thành phố
                    const Align(
                        child: Text('Khu vực giao dịch',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Tỉnh / Thành phố'),
                    const SizedBox(
                      height: 20,
                    ),
                    citiesDropDown(),
                    const SizedBox(
                      height: 25,
                    ),
                    // Quận
                    const Text('Quận / Huyện'),
                    const SizedBox(
                      height: 20,
                    ),
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
                              child: const Text('Cập nhật'),
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

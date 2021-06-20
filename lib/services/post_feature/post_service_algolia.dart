import 'package:algolia/algolia.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';

class PostServiceAlgolia {
  final Algolia algolia = Application.algolia;

  Future<void> addPost(
      {required String objectID,
      required String name,
      required String mainCategoy,
      required String subCategory,
      required List<String> wishMainCategory,
      required String imageURL, // lẩy ảnh đầu [0] bỏ vô đc r
      required String condition,
      required int price,
      required String
          district // từ map address lấy thông tin cái quận lưu dô thôi,ex: 5
      }) async {
    final mapData = <String, dynamic>{
      'objectID': objectID,
      'name': name,
      'mainCategoy': mainCategoy,
      'subCategory': subCategory,
      'wishMainCategory': wishMainCategory,
      'imageURL': imageURL,
      'condition': condition,
      'price': price,
      'district': district,
    };
    await algolia.instance.index(postsAlgoliaIndex).addObject(mapData);
  }

  Future<void> updatePost(
      {required String objectID,
      required String name,
      required String mainCategoy,
      required String subCategory,
      required List<String> wishMainCategory,
      required String imageURL, // lẩy ảnh đầu [0] bỏ vô đc r
      required String condition,
      required int price,
      required String
          district // từ map address lấy thông tin cái quận lưu dô thôi,ex: 5
      }) async {
    final mapData = <String, dynamic>{
      'objectID': objectID,
      'name': name,
      'mainCategoy': mainCategoy,
      'subCategory': subCategory,
      'wishMainCategory': wishMainCategory,
      'imageURL': imageURL,
      'condition': condition,
      'price': price,
      'district': district,
    };
    await algolia.instance
        .index(usersAlgoliaIndex)
        .object(objectID)
        .updateData(mapData);
  }
}

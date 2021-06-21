import 'package:algolia/algolia.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';

class PostServiceAlgolia {
  final Algolia algolia = Application.algolia;

  Future<void> addPost({
    required String objectID,
    required String name,
    required String mainCategoyId,
    required String subCategoryId,
    required List<String> tradeForList,
    required String imageURL, // lẩy ảnh đầu [0] bỏ vô đc r
    required String condition,
    required int price,
    required String
        district, // từ map address lấy thông tin cái quận lưu dô thôi,ex: 5
    required String city,
  }) async {
    final mapData = <String, dynamic>{
      'objectID': objectID,
      'name': name,
      'mainCategoyId': mainCategoyId,
      'subCategoryId': subCategoryId,
      'tradeForList': tradeForList,
      'imageURL': imageURL,
      'condition': condition,
      'price': price,
      'district': district,
      'city': city
    };
    await algolia.instance.index(postsAlgoliaIndex).addObject(mapData);
  }

  Future<void> updatePost({
    required String objectID,
    required String name,
    required String mainCategoyId,
    required String subCategoryId,
    required List<String> tradeForList,
    required String imageURL, // lẩy ảnh đầu [0] bỏ vô đc r
    required String condition,
    required int price,
    required String
        district, // từ map address lấy thông tin cái quận lưu dô thôi,ex: 5
    required String city,
  }) async {
    final mapData = <String, dynamic>{
      'objectID': objectID,
      'name': name,
      'mainCategoyId': mainCategoyId,
      'subCategoryId': subCategoryId,
      'tradeForList': tradeForList,
      'imageURL': imageURL,
      'condition': condition,
      'price': price,
      'district': district,
      'city': city,
    };
    await algolia.instance
        .index(postsAlgoliaIndex)
        .object(objectID)
        .updateData(mapData);
  }

  Future<List<AlgoliaObjectSnapshot>> searchPostByAlgolia(String query) {
    return algolia.instance
        .index(postsAlgoliaIndex)
        .query(query)
        .getObjects()
        .then((result) => result.hits);
  }

  Future<List<String>> searchPostCard(String query) async {
    final result = await searchPostByAlgolia(query);
    final postsIds = <String>[];
    for (final hit in result) {
      postsIds.add(hit.data['objectID'].toString());
    }
    return postsIds;
  }

}

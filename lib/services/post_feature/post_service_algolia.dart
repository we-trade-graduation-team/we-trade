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
      'condition': condition,
      'price': price,
      'district': district,
      'city': city,
    };
    await algolia.instance.index(postsAlgoliaIndex).addObject(mapData);
  }

  Future<void> updatePost({
    required String objectID,
    required String name,
    required String mainCategoyId,
    required String subCategoryId,
    required List<String> tradeForList,
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

  Future<List<AlgoliaObjectSnapshot>> searchPostByAlgolia(
      String str, String cateId, String city, String condition) async {
    var query = algolia.instance.index(postsAlgoliaIndex).query(str);
    if (cateId.isNotEmpty) {
      query = query.facetFilter('mainCategoyId:$cateId');
    }
    if (city.isNotEmpty) {
      query = query.facetFilter('city:$city');
    }
    if (condition.isNotEmpty) {
      query = query.facetFilter('condition:$condition');
    }

    final result = await query.getObjects();
    return result.hits;
  }

  Future<List<String>> searchPostCard(
      String query, String cateId, String city, String condition) async {
    final result = await searchPostByAlgolia(query, cateId, city, condition);
    final postsIds = <String>[];
    for (final hit in result) {
      postsIds.add(hit.data['objectID'].toString());
    }
    return postsIds;
  }
}

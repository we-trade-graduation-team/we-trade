import 'package:cloud_firestore/cloud_firestore.dart';

class PostServiceFireStore {
  Future<QuerySnapshot<Map<String, dynamic>>> getMainCategory() {
    try {
      return FirebaseFirestore.instance
          .collection('categories')
          .orderBy('category')
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSubCategory(
      String mainCategory) {
    try {
      return FirebaseFirestore.instance
          .collection('categories')
          .where('category', isEqualTo: mainCategory)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          return value.docs[0].reference.collection('subCategory').get();
        }
        return value;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCities() {
    try {
      return FirebaseFirestore.instance
          .collection('locations')
          .orderBy('city')
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDistrict(String city) {
    try {
      return FirebaseFirestore.instance
          .collection('locations')
          .where('city', isEqualTo: city)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          return value.docs[0].reference
              .collection('districts')
              .orderBy('district')
              .get();
        }
        return value;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getKeyword() {
    try {
      return FirebaseFirestore.instance
          .collection('keywords')
          .orderBy('keyword')
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCondition() {
    try {
      return FirebaseFirestore.instance
          .collection('conditions')
          .orderBy('priority')
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addKeyword(String keyword) async {
    try {
      final CollectionReference keywordDB =
          FirebaseFirestore.instance.collection('keywords');
      final doc = await keywordDB.add({'keyword': keyword});
      return doc.id;
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> addPost(Map arguments) async {
    try {
      final CollectionReference postDB =
          FirebaseFirestore.instance.collection('posts');
      final doc = await postDB.add(arguments);
      return doc.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addPostCard(Map arguments, String postId) async {
    try {
      final CollectionReference postCard =
          FirebaseFirestore.instance.collection('postCards');
      await postCard.doc(postId).set(arguments);
      return '1';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addJunctionKeywordPost(
      List<String> idKeyword, String postId) async {
    try {
      final CollectionReference keywordPost =
          FirebaseFirestore.instance.collection('junctionKeywordPost');

      for (final idKey in idKeyword) {
        final docId = '${idKey}_$postId';
        await keywordPost.doc(docId).set({
          'keywordId': idKey,
          'postId': postId,
        });
      }
      return '1';
    } catch (e) {
      rethrow;
    }
  }
}

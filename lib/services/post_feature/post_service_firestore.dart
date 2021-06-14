import 'package:cloud_firestore/cloud_firestore.dart';

class PostServiceFireStore {
  Future<QuerySnapshot<Map<String, dynamic>>> getMainCategory() {
    try {
      return FirebaseFirestore.instance
          .collection('thientin')
          .doc('category')
          .collection('categoryList')
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSubCategory(
      String mainCategory) {
    try {
      return FirebaseFirestore.instance
          .collection('thientin')
          .doc('category')
          .collection('categoryList')
          .where('category_name', isEqualTo: mainCategory)
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
          .collection('vietNamCities')
          .orderBy('city')
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDistrict(String city) {
    try {
      return FirebaseFirestore.instance
          .collection('vietNamCities')
          .where('city', isEqualTo: city)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          return value.docs[0].reference
              .collection('district')
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
      return FirebaseFirestore.instance.collection('keywords').get();
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
          FirebaseFirestore.instance.collection('post');
      final doc = await postDB.add(arguments);
      return doc.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addPostCard(Map arguments) async {
    try {
      final CollectionReference postCard =
          FirebaseFirestore.instance.collection('postCards');
      final doc = await postCard.add(arguments);
      return doc.id;
    } catch (e) {
      rethrow;
    }
  }
}

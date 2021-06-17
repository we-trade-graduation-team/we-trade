import 'package:cloud_firestore/cloud_firestore.dart';

class PostServiceFireStore {
  Future<QuerySnapshot<Map<String, dynamic>>> getMainCategory() {
    return FirebaseFirestore.instance
        .collection('thientin')
        .doc('category')
        .collection('categoryList')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSubCategory(
      String mainCategory) {
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
  }
}

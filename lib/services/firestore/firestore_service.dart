import 'package:cloud_firestore/cloud_firestore.dart';

/*
  This class represent all possible CRUD operation for Firestore.
  It contains all generic implementation needed based on the provided document
  path and documentID,since most of the time in Firestore design, we will have
  documentID and path for any document and collections.
 */

void _handleError(Object? e) {
  throw Exception(e?.toString());
}

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final _fireStoreInstance = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _fireStoreInstance.doc(path);

    final setOptions = SetOptions(merge: merge);

    await reference.set(data, setOptions).catchError(_handleError);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _fireStoreInstance.doc(path);

    await reference.update(data).catchError(_handleError);
  }

  Future<void> deleteData({
    required String path,
  }) async {
    final reference = _fireStoreInstance.doc(path);

    await reference.delete().catchError(_handleError);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(QueryDocumentSnapshot) builder,
    Query Function(Query)? queryBuilder,
    // int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStoreInstance.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshots = query.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot))
          .where((value) => value != null)
          .toList();

      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(DocumentSnapshot) builder,
  }) {
    final reference = _fireStoreInstance.doc(path);

    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) => builder(snapshot));
  }

  Future<List<T>> collectionFuture<T>({
    required String path,
    required T Function(QueryDocumentSnapshot) builder,
    Query Function(Query)? queryBuilder,
  }) async {
    Query query = _fireStoreInstance.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final querySnapshot = await query.get();

    final result = querySnapshot.docs
        .map((doc) => builder(doc))
        .where((value) => value != null)
        .toList();

    return result;
  }

  Future<T> documentFuture<T>({
    required String path,
    required T Function(DocumentSnapshot) builder,
  }) async {
    final reference = _fireStoreInstance.doc(path);

    final documentSnapshot = await reference.get();

    final result = builder(documentSnapshot);

    return result;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/firestore_errors/firestore_errors.dart';
import '../../utils/helper/error_helper/error_helper.dart';

/*
  This class represent all possible CRUD operation for Firestore.
  It contains all generic implementation needed based on the provided document
  path and documentID,since most of the time in Firestore design, we will have
  documentID and path for any document and collections.
 */

void _handleError(Object? e) {
  throw Exception(e?.toString());
}

// Future<void> __handleFutureError(Object? e) {
//   throw Exception(e?.toString());
// }

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final _fireStoreInstance = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final _reference = _fireStoreInstance.doc(path);

    await Future.wait([
      // Check if doc is exists
      _reference.get().then((snapshot) async {
        if (!snapshot.exists) {
          ErrorHelper.throwArgumentError(
            message: FirestoreErrors.errorDocumentNotExists,
          );
        }
      }),
      // If doc is exists then update it
      _reference.set(data, SetOptions(merge: merge)).catchError(_handleError),
    ]);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final _reference = _fireStoreInstance.doc(path);

    await Future.wait([
      // Check if doc is exists
      _reference.get().then((snapshot) async {
        if (!snapshot.exists) {
          ErrorHelper.throwArgumentError(
            message: FirestoreErrors.errorDocumentNotExists,
          );
        }
      }),
      // If doc is exists then update it
      _reference.update(data).catchError(_handleError),
    ]);
  }

  Future<void> deleteData({
    required String path,
  }) async {
    final _reference = _fireStoreInstance.doc(path);

    await Future.wait([
      // Check if doc is exists
      _reference.get().then((snapshot) async {
        if (!snapshot.exists) {
          ErrorHelper.throwArgumentError(
            message: FirestoreErrors.errorDocumentNotExists,
          );
        }
      }),
      // If doc is exists then delete it
      _reference.delete().catchError(_handleError),
    ]);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(QueryDocumentSnapshot) builder,
    Query Function(Query)? queryBuilder,
  }) {
    Query _query = _fireStoreInstance.collection(path);

    if (queryBuilder != null) {
      _query = queryBuilder(_query);
    }

    final _snapshots = _query.snapshots();

    return _snapshots.map((snapshot) {
      final _result = snapshot.docs
          .map((snapshot) {
            if (!snapshot.exists) {
              ErrorHelper.throwArgumentError(
                message: FirestoreErrors.errorDocumentNotExists,
              );
            }

            return builder(snapshot);
          })
          .where((value) => value != null)
          .toList();

      return _result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(DocumentSnapshot) builder,
  }) {
    final _reference = _fireStoreInstance.doc(path);

    final _snapshots = _reference.snapshots();

    return _snapshots.map((snapshot) {
      if (!snapshot.exists) {
        ErrorHelper.throwArgumentError(
          message: FirestoreErrors.errorDocumentNotExists,
        );
      }

      return builder(snapshot);
    });
  }

  Future<List<T>> collectionFuture<T>({
    required String path,
    required T Function(QueryDocumentSnapshot) builder,
    Query Function(Query)? queryBuilder,
  }) async {
    Query _query = _fireStoreInstance.collection(path);

    if (queryBuilder != null) {
      _query = queryBuilder(_query);
    }

    final _querySnapshot = await _query.get();

    final _result = _querySnapshot.docs
        .map((snapshot) {
          if (!snapshot.exists) {
            ErrorHelper.throwArgumentError(
              message: FirestoreErrors.errorDocumentNotExists,
            );
          }

          return builder(snapshot);
        })
        .where((value) => value != null)
        .toList();

    return _result;
  }

  Future<T> documentFuture<T>({
    required String path,
    required T Function(DocumentSnapshot) builder,
  }) async {
    final _reference = _fireStoreInstance.doc(path);

    final _snapshot = await _reference.get();

    if (!_snapshot.exists) {
      ErrorHelper.throwArgumentError(
        message: FirestoreErrors.errorDocumentNotExists,
      );
    }

    final _result = builder(_snapshot);

    return _result;
  }

  // Future<void> updateDataTransaction({
  //   required String path,
  //   required Map<String, dynamic> data,
  // }) async {
  //   final _reference = _fireStoreInstance.doc(path);

  //   // This code may get re-run multiple times if there are conflicts.
  //   await _fireStoreInstance
  //       .runTransaction((transaction) {
  //         return transaction.get(_reference).then((snapshot) {
  //           if (!snapshot.exists) {
  //             _throwArgumentError(
  //                 message: FirestoreErrors.errorDocumentNotExists);
  //           }

  //           // var newPopulation = snapshot.data().population + 1;
  //           // transaction.update(sfDocRef, { population: newPopulation });
  //         });
  //       })
  //       .then((value) => null)
  //       .catchError(__handleFutureError);
  // }

}

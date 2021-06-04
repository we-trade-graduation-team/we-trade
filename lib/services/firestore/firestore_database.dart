import 'dart:async';

import '../../models/cloud_firestore/category_card/category_card.dart';
import '../../models/cloud_firestore/post_card_models/post_card/post_card.dart';
import '../../models/cloud_firestore/post_card_models/user_recommended_post_card/user_recommended_post_card.dart';
import '../../models/cloud_firestore/special_offer_card_models/special_offer_card/special_offer_card.dart';
import '../../models/cloud_firestore/special_offer_card_models/user_special_offer_cards/user_special_offer_card.dart';
import '../../models/cloud_firestore/user/user.dart' as user_model;
import 'firestore_path.dart';
import 'firestore_service.dart';

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in Firestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todo item to have the complete status
changed to true.

 */

class FirestoreDatabase {
  FirestoreDatabase({
    required this.uid,
  });

  final String uid;

  final _fireStoreService = FirestoreService.instance;

  //Method to update user info
  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> newData,
  }) async {
    await _fireStoreService.updateData(
      path: FirestorePath.user(uid: uid),
      data: newData,
    );
  }

  // Method to retrieve all user details from Firestore
  Stream<List<user_model.User>> usersStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.users(),
      builder: (data) => user_model.User.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve a User
  Stream<user_model.User> userStream() {
    return _fireStoreService.documentStream(
      path: FirestorePath.user(uid: uid),
      builder: (data) => user_model.User.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Post Cards from the same user based on uid
  Stream<List<PostCard>> userPostCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.userPostCards(uid: uid),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Special Offer Cards from the same user based on uid
  Stream<List<UserSpecialOfferCard>> userSpecialOfferCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.userSpecialOfferCards(uid: uid),
      queryBuilder: (query) {
        return query
            .orderBy(
              'view',
              descending: true,
            )
            .limit(10);
      },
      builder: (data) => UserSpecialOfferCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Recommended Post Cards from the same user based on uid
  Stream<List<UserRecommendedPostCard>> userRecommendedPostCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.userRecommendedPostCards(uid: uid),
      builder: (data) => UserRecommendedPostCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Favorite Post Cards from the same user based on uid
  Stream<List<PostCard>> userFavoritePostCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.userFavoritePostCards(uid: uid),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Category Cards
  Stream<List<CategoryCard>> categoryCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.categoryCards(),
      builder: (data) => CategoryCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve top 10 Special Offer Cards
  Stream<List<SpecialOfferCard>> specialOfferCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.specialOfferCards(),
      queryBuilder: (query) {
        return query
            .orderBy(
              'view',
              descending: true,
            )
            .limit(10);
      },
      builder: (data) => SpecialOfferCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve Recommended Post Cards
  Stream<List<PostCard>> recommendedPostCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.postCards(),
      queryBuilder: (query) {
        return query.orderBy(
          'view',
          descending: true,
        );
      },
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Popular Post Cards
  Stream<List<PostCard>> popularPostCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.postCards(),
      queryBuilder: (query) {
        return query
            .where(
              'view',
              isGreaterThan: 0,
            )
            .orderBy(
              'view',
              descending: true,
            )
            .limit(30);
      },
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Post Cards
  Stream<List<PostCard>> postCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.postCards(),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve a Post Cards based on postId
  Stream<List<PostCard>> postCardStream({
    required String postId,
  }) {
    return _fireStoreService.collectionStream(
      path: FirestorePath.postCard(postId: postId),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }

  // //Method to create/update todoModel
  // Future<void> setTodo(TodoModel todo) async {
  //   await _fireStoreService.setData(
  //     path: FirestorePath.todo(uid, todo.id),
  //     data: todo.toMap(),
  //   );
  // }

  // //Method to delete todoModel entry
  // Future<void> deleteTodo(TodoModel todo) async {
  //   await _fireStoreService.deleteData(path: FirestorePath.todo(uid, todo.id));
  // }

  // //Method to mark all todoModel to be complete
  // Future<void> setAllTodoComplete() async {
  //   final batchUpdate = Firestore.instance.batch();

  //   final querySnapshot = await Firestore.instance
  //       .collection(FirestorePath.todo(uid))
  //       .getDocuments();

  //   for (DocumentSnapshot ds in querySnapshot.documents) {
  //     batchUpdate.updateData(ds.reference, {'complete': true});
  //   }
  //   await batchUpdate.commit();
  // }

  // Future<void> deleteAllTodoWithComplete() async {
  //   final batchDelete = Firestore.instance.batch();

  //   final querySnapshot = await Firestore.instance
  //       .collection(FirestorePath.todo(uid))
  //       .where('complete', isEqualTo: true)
  //       .getDocuments();

  //   for (DocumentSnapshot ds in querySnapshot.documents) {
  //     batchDelete.delete(ds.reference);
  //   }
  //   await batchDelete.commit();
  // }
}

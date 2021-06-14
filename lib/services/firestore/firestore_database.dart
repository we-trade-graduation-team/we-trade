import 'dart:async';

import '../../models/cloud_firestore/category_card/category_card.dart';
import '../../models/cloud_firestore/junction_keyword_post/junction_keyword_post.dart';
import '../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../models/cloud_firestore/special_category_card/special_category_card.dart';
import '../../models/cloud_firestore/user_model/user/user.dart' as user_model;
import '../../utils/helper/model_properties/keyword/keyword_properties.dart';
import '../../utils/helper/model_properties/post_card/post_card_properties.dart';
import '../../utils/helper/model_properties/special_category_card/special_category_card_properties.dart';
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

  Future<user_model.User> _getCurrentUser() async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.user(uid: uid),
      builder: (data) => user_model.User.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to update user info
  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> newData,
  }) async {
    await _fireStoreService.updateData(
      path: FirestorePath.user(uid: uid),
      data: newData,
    );
  }

  // Method to retrieve a Special Category Card
  Future<SpecialCategoryCard> _getSpecialCategoryCard({
    required String categoryId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.specialCategoryCard(categoryId: categoryId),
      builder: (data) => SpecialCategoryCard.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve a Special Category Card
  Future<List<SpecialCategoryCard>> _getSpecialCategoryCards({
    required int limit,
    String? fieldToOrder,
  }) async {
    final _defaultOrderField =
        SpecialCategoryCardProperties.getProp('view') as String;

    final _orderField = fieldToOrder ?? _defaultOrderField;

    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.specialCategoryCards(),
      queryBuilder: (query) {
        return query.orderBy(_orderField).limit(limit);
      },
      builder: (data) => SpecialCategoryCard.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve a Post Card
  Future<PostCard> _getPostCard({
    required String postId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.postCard(postId: postId),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve Post Cards
  Future<List<PostCard>> _getPostCards({
    required int limit,
    String? fieldToOrder,
  }) async {
    final _defaultOrderField = PostCardProperties.getProp('view') as String;

    final _orderField = fieldToOrder ?? _defaultOrderField;

    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.postCards(),
      queryBuilder: (query) {
        return query.orderBy(_orderField).limit(limit);
      },
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve top 10 Special Category Cards
  Future<List<SpecialCategoryCard>> specialCategoryCardsFuture() async {
    final _currentUser = await _getCurrentUser();

    // Get user's category history
    final _currentUserCategoryHistory = _currentUser.categoryHistory;

    const _numberOfDocumentToTake = 10;

    // If null or empty
    if (_currentUserCategoryHistory == null ||
        _currentUserCategoryHistory.isEmpty) {
      final _result =
          await _getSpecialCategoryCards(limit: _numberOfDocumentToTake);

      return _result;
    }

    // Sort category history by times - descending
    _currentUserCategoryHistory.sort((a, b) => b.times.compareTo(a.times));

    // Get top 10 times categoryId of user
    final _topCategory = _currentUserCategoryHistory
        .take(_numberOfDocumentToTake)
        .map((categoryHistory) => categoryHistory.categoryId)
        .toList();

    final _result = Stream.fromIterable(_topCategory)
        .asyncMap(
            (categoryId) => _getSpecialCategoryCard(categoryId: categoryId))
        .toList();

    return _result;
  }

  // Method to retrieve a Post Card
  Future<List<JunctionKeywordPost>> _getJunctionKeywordPost({
    required String keywordId,
  }) async {
    final _defaultFilerField = KeywordProperties.getProp('keywordId') as String;

    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.junctionKeywordPost(),
      queryBuilder: (query) {
        return query.where(
          _defaultFilerField,
          isEqualTo: keywordId,
        );
      },
      builder: (data) => JunctionKeywordPost.fromDocumentSnapshot(data),
    );

    return _result;
  }

  Future<List<PostCard>> recommendedPostCardsFuture() async {
    final _currentUser = await _getCurrentUser();

    // Get user's search history
    final _currentUserKeywordHistory = _currentUser.keywordHistory;

    // Decide to take top 20 most view post cards from all keywords
    const _numberOfPostCardToTake = 20;

    // If null or empty
    if (_currentUserKeywordHistory == null ||
        _currentUserKeywordHistory.isEmpty) {
      // Take top 20 most view post cards
      final _result = await _getPostCards(limit: _numberOfPostCardToTake);

      return _result;
    }

    // Sort descending category history by times
    _currentUserKeywordHistory.sort((a, b) => b.times.compareTo(a.times));

    // Decide to take top 4 most view times keyword
    const _numberOfKeywordToTake = 4;

    // Get top _numberOfKeywordToTake times keyword of user
    final _topKeyword = _currentUserKeywordHistory
        .take(_numberOfKeywordToTake)
        .map((keywordHistory) => keywordHistory.keywordId)
        .toList();

    // Not empty because _currentUserKeywordHistory.isNotEmpty is false
    // if (_topKeyword.isNotEmpty) {}

    // Fetch all list the keywords’ junction documents from top
    // _numberOfKeywordToTake keyword,
    final _junctionsList = await Stream.fromIterable(_topKeyword)
        .asyncMap((keywordId) => _getJunctionKeywordPost(keywordId: keywordId))
        .toList();

    // Equally divided the quantity of post cards for each keyword
    // Example: If user has less keyword than _numberOfKeywordToTake
    // then take only those keyword, otherwise take _numberOfKeywordToTake
    final _numberToDivide = _topKeyword.length < _numberOfKeywordToTake
        ? _topKeyword.length
        : _numberOfKeywordToTake;

    final _numberOfPostCardEachKeywordToTake =
        _numberOfPostCardToTake ~/ _numberToDivide;

    // For each junctions corresponding each keyword - post cards
    final _keyWordPostCardsList =
        await Stream.fromIterable(_junctionsList).asyncMap((
      _junctions,
    ) async {
      // Fetch for each retrieved junction, fetch the associated postCard
      final _postCardsFromJunction = await Stream.fromIterable(_junctions)
          .asyncMap((junction) => _getPostCard(postId: junction.postId))
          .toList();

      // Sort descending by view
      _postCardsFromJunction.sort((a, b) => b.view.compareTo(a.view));

      // Get most view post card
      final _postCardToTake = _postCardsFromJunction
          .take(_numberOfPostCardEachKeywordToTake)
          .toList();

      return _postCardToTake;
    }).toList();

    // Flatten list
    final _flattenPostCardList =
        _keyWordPostCardsList.expand((postCards) => postCards).toList();

    return _flattenPostCardList;
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

  // Method to retrieve all Category Cards
  Stream<List<CategoryCard>> categoryCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.categoryCards(),
      builder: (data) => CategoryCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Popular Post Cards
  Stream<List<PostCard>> popularPostCardsStream() {
    final _viewField = PostCardProperties.getProp('view') as String;

    final _defaultFilerField = _viewField;

    final _defaultOrderField = _viewField;

    const _numberOfDocumentToTake = 30;

    const _isDescendingOrder = true;

    return _fireStoreService.collectionStream(
      path: FirestorePath.postCards(),
      queryBuilder: (query) {
        return query
            .where(
              _defaultFilerField,
              isGreaterThan: 0,
            )
            .orderBy(
              _defaultOrderField,
              descending: _isDescendingOrder,
            )
            .limit(_numberOfDocumentToTake);
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

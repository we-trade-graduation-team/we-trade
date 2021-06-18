import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import '../../constants/app_firestore_constant.dart';
import '../../models/cloud_firestore/category_card/category_card.dart';
import '../../models/cloud_firestore/category_events/category_events.dart';
import '../../models/cloud_firestore/junction_keyword_post/junction_keyword_post.dart';
import '../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../models/cloud_firestore/special_category_card/special_category_card.dart';
import '../../models/cloud_firestore/user_model/user/user.dart' as user_model;
import '../../models/cloud_firestore/user_model/user_category_history/user_category_history.dart';
import '../../models/cloud_firestore/user_model/user_keyword_history/user_keyword_history.dart';
import '../../utils/firestore_errors/firestore_errors.dart';
import '../../utils/helper/error_helper/error_helper.dart';
import '../../utils/model_properties/model_properties.dart';
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

  final _fireStoreInstance = FirebaseFirestore.instance;

  Future<user_model.User> _getCurrentUser() async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.user(uid: uid),
      builder: (data) => user_model.User.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to update user info
  Future<void> updateCurrentUser({
    // required String uid,
    required Map<String, dynamic> newData,
  }) async {
    await _fireStoreService.updateData(
      path: FirestorePath.user(uid: uid),
      data: newData,
    );
  }

  // Method to update user info
  Future<void> setCurrentUserData({
    // required String uid,
    required Map<String, dynamic> newData,
    bool merge = false,
  }) async {
    await _fireStoreService.setData(
      path: FirestorePath.user(uid: uid),
      data: newData,
      merge: merge,
    );
  }

  // Method to update postCard info
  Future<void> updatePostCard({
    required String postId,
    required Map<String, dynamic> newData,
  }) async {
    await _fireStoreService.updateData(
      path: FirestorePath.postCard(postId: postId),
      data: newData,
    );
  }

  // Method to increase postCard's view
  Future<void> increasePostCardView({
    required String postId,
    // Default, amount is one
    int amount = 1,
  }) async {
    const _viewField = ModelProperties.postCardViewProperty;

    final _newData = {
      _viewField: FieldValue.increment(amount),
    };

    await updatePostCard(
      postId: postId,
      newData: _newData,
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
  Future<CategoryEvents> _getCategoryEvents({
    required String categoryId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.categoryEvents(categoryId: categoryId),
      builder: (data) => CategoryEvents.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve a Special Category Card
  Future<List<SpecialCategoryCard>> _getSpecialCategoryCards({
    required int limit,
    String? fieldToOrder,
    List<String>? excludedCategoryIdList,
  }) async {
    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.specialCategoryCards(),
      queryBuilder: (query) {
        // If has this argument
        if (excludedCategoryIdList != null &&
            excludedCategoryIdList.isNotEmpty) {
          const _maxWhereNotInAmount =
              AppFirestoreConstant.whereNotInAmountMaximum;

          if (excludedCategoryIdList.length > _maxWhereNotInAmount) {
            ErrorHelper.throwArgumentError(
              message:
                  FirestoreErrors.errorWhereNotInMaximumUpToTenComparisonValues,
            );
          }
          // final _idField = ModelProperties.specialCategoryCardIdProperty;

          return query
              .where(FieldPath.documentId, whereNotIn: excludedCategoryIdList)
              .limit(limit);
        }

        const _defaultOrderField =
            ModelProperties.specialCategoryCardViewProperty;

        final _orderField = fieldToOrder ?? _defaultOrderField;

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
    List<String>? excludedPostIdList,
  }) async {
    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.postCards(),
      queryBuilder: (query) {
        // If has this argument
        if (excludedPostIdList != null) {
          const _maxWhereNotInAmount =
              AppFirestoreConstant.whereNotInAmountMaximum;

          if (excludedPostIdList.length > _maxWhereNotInAmount) {
            ErrorHelper.throwArgumentError(
              message:
                  FirestoreErrors.errorWhereNotInMaximumUpToTenComparisonValues,
            );
          }
          // final _idField = ModelProperties.postCardIdProperty;

          return query
              .where(FieldPath.documentId, whereNotIn: excludedPostIdList)
              .limit(limit);
        }

        const _defaultOrderField = ModelProperties.postCardViewProperty;

        final _orderField = fieldToOrder ?? _defaultOrderField;

        return query.orderBy(_orderField).limit(limit);
      },
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
    return _result;
  }

  Future<List<PostCard>> getPostCardsByPostIdList({
    required List<String> postIdList,
  }) async {
    final _result = await Stream.fromIterable(postIdList)
        .asyncMap((postId) => _getPostCard(postId: postId))
        .toList();

    return _result;
  }

  // Method to retrieve top 10 Special Category Cards
  Future<List<SpecialCategoryCard>> specialCategoryCardsFuture() async {
    final _currentUser = await _getCurrentUser();

    // Get user's category history
    final _currentUserCategoryHistory = _currentUser.categoryHistory;

    const _numberOfDocumentToTake =
        AppFirestoreConstant.kHomeScreenSpecialCategoryCardAmount;

    // If null or empty
    if (_currentUserCategoryHistory == null ||
        _currentUserCategoryHistory.isEmpty) {
      final _result =
          await _getSpecialCategoryCards(limit: _numberOfDocumentToTake);

      return _result;
    }

    // Sort category history by times - descending
    _currentUserCategoryHistory.sort((a, b) => b.times.compareTo(a.times));

    // Get top times categoryId of user
    final _topCategory = _currentUserCategoryHistory
        .take(_numberOfDocumentToTake)
        .map((categoryHistory) => categoryHistory.categoryId)
        .toList();

    // Get special category cards according category Id
    final _specialCategoryCards = await Stream.fromIterable(_topCategory)
        .asyncMap(
            (categoryId) => _getSpecialCategoryCard(categoryId: categoryId))
        .toList();

    // Return if has enough cards
    if (_specialCategoryCards.length == _numberOfDocumentToTake) {
      return _specialCategoryCards;
    }

    // Calculate number of missing cards
    final _missingAmount =
        _numberOfDocumentToTake - _specialCategoryCards.length;

    // Get categoryId from existing specialCategoryCards
    final _excludedCategoryIdList = _specialCategoryCards
        .map((specialCategoryCard) => specialCategoryCard.categoryId!)
        .toList();

    // Don't have to check because we take only 5 special category cards
    // const _maxWhereNotInAmount = AppFirestoreConstant.whereNotInAmountMaximum;
    // if (_excludedCategoryIdList.length > _maxWhereNotInAmount) {}

    // Get more to have enough special category card
    final _mostViewSpecialCategoryCards = await _getSpecialCategoryCards(
      limit: _missingAmount,
      excludedCategoryIdList: _excludedCategoryIdList,
    );

    // Locally sorting descending by view - because =>
    // If you include a filter with a range comparison (<, <=, >, >=),
    // your first ordering must be on the same field:
    _mostViewSpecialCategoryCards.sort((a, b) => b.view.compareTo(a.view));

    // Concatenate two list
    final _fullList = [
      ..._specialCategoryCards,
      ..._mostViewSpecialCategoryCards
    ];

    return _fullList;
  }

  // Method to retrieve Junction Keyword Post List by keyword Id
  Future<List<JunctionKeywordPost>> _getJunctionKeywordPostByKeywordId({
    required String keywordId,
  }) async {
    const _filterField = ModelProperties.keywordKeywordIdProperty;

    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.junctionKeywordPost(),
      queryBuilder: (query) {
        return query.where(
          _filterField,
          isEqualTo: keywordId,
        );
      },
      builder: (data) => JunctionKeywordPost.fromDocumentSnapshot(data),
    );

    return _result;
  }

  // Method to retrieve Junction Keyword Post List by post Id
  Future<List<JunctionKeywordPost>> _getJunctionKeywordPostByPostId({
    required String postId,
  }) async {
    const _filterField = ModelProperties.keywordPostIdProperty;

    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.junctionKeywordPost(),
      queryBuilder: (query) {
        return query.where(
          _filterField,
          isEqualTo: postId,
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

    // Decide to take top most view post cards from all keywords
    const _numberOfPostCardToTake =
        AppFirestoreConstant.kHomeScreenRecommendedPostCardEachPullAmount;

    // If null or empty
    if (_currentUserKeywordHistory == null ||
        _currentUserKeywordHistory.isEmpty) {
      // Take top most view post cards
      final _result = await _getPostCards(limit: _numberOfPostCardToTake);

      return _result;
    }

    // Sort descending category history by times
    _currentUserKeywordHistory.sort((a, b) => b.times.compareTo(a.times));

    // Decide to take top most view times keyword
    const _numberOfKeywordToTake =
        AppFirestoreConstant.kHomeScreenRecommendedPostCardUserKeywordAmount;

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
        .asyncMap((keywordId) =>
            _getJunctionKeywordPostByKeywordId(keywordId: keywordId))
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

    // Return if has enough cards
    if (_flattenPostCardList.length == _numberOfPostCardToTake) {
      return _flattenPostCardList;
    }

    // Calculate number of missing cards
    final _missingAmount =
        _numberOfPostCardToTake - _flattenPostCardList.length;

    // Get postId from existing postCardList
    final _excludedPostIdList =
        _flattenPostCardList.map((postCard) => postCard.postId!).toList();

    const _maxWhereNotInAmount = AppFirestoreConstant.whereNotInAmountMaximum;

    if (_excludedPostIdList.length <= _maxWhereNotInAmount) {
      // Get more to have enough post card
      final _mostViewPostCards = await _getPostCards(
        limit: _missingAmount,
        excludedPostIdList: _excludedPostIdList,
      );

      // Locally sorting descending by view - because =>
      // If you include a filter with a range comparison (<, <=, >, >=),
      // your first ordering must be on the same field:
      _mostViewPostCards.sort((a, b) => b.view.compareTo(a.view));

      // Concatenate two list
      final _fullList = [..._flattenPostCardList, ..._mostViewPostCards];

      return _fullList;
    }

    // Separate list

    // First list contains item from index 0 => 9
    final _firstHalfExcludedPostIdList =
        _excludedPostIdList.sublist(0, _maxWhereNotInAmount);

    // Second list contains item from index 10 => end
    final _secondHalfExcludedPostIdList =
        _excludedPostIdList.sublist(_maxWhereNotInAmount);

    // Get more postCard excluded first half
    // plus _secondHalfExcludedPostIdList.length
    final _mostViewPostCardsExcludedFirstHalf = await _getPostCards(
      // Plus more
      limit: _missingAmount + _secondHalfExcludedPostIdList.length,
      excludedPostIdList: _firstHalfExcludedPostIdList,
    );

    // Remove postCard where postId is in second half
    _mostViewPostCardsExcludedFirstHalf.removeWhere(
        (postCard) => _secondHalfExcludedPostIdList.contains(postCard.postId));

    // Sort descending by view
    _mostViewPostCardsExcludedFirstHalf
        .sort((a, b) => b.view.compareTo(a.view));

    // If have take enough missing amount
    if (_mostViewPostCardsExcludedFirstHalf.length == _missingAmount) {
      // Concatenate two list
      final _fullList = [
        ..._flattenPostCardList,
        ..._mostViewPostCardsExcludedFirstHalf
      ];

      return _fullList;
    }

    // Else, we have take more than enough than take exactly amount missing
    final _exactlyAmountMissingPostCardList =
        _mostViewPostCardsExcludedFirstHalf.take(_missingAmount).toList();

    // Concatenate two list
    final _fullList = [
      ..._flattenPostCardList,
      ..._exactlyAmountMissingPostCardList
    ];

    return _fullList;
  }

  // Increase view of category in all path by one (default)
  Future<void> increaseCategoryView({
    required String categoryId,
    int amount = 1,
  }) async {
    // Create a placeholder for update object
    final _updateObj = <String, Map<String, FieldValue>>{};

    // Get view's property name
    const _viewField = ModelProperties.categoryViewProperty;

    // Update value
    final _newData = {
      _viewField: FieldValue.increment(amount),
    };

    // Get category events
    final _categoryEvents = await _getCategoryEvents(categoryId: categoryId);

    final _events = _categoryEvents.events;

    // Create entries
    for (final event in _events) {
      final _entry = '$event/$categoryId';
      _updateObj[_entry] = _newData;
    }
    // Get a new write batch
    final _batch = _fireStoreInstance.batch();

    for (var i = 0; i < _updateObj.length; i++) {
      // Get path
      final _path = _updateObj.keys.elementAt(i);

      // Get reference of path
      final _ref = _fireStoreInstance.doc(_path);

      // Get snapshot
      final _snapshot = await _ref.get();

      // Check if doc is exists
      if (!_snapshot.exists) {
        ErrorHelper.throwArgumentError(
          message: FirestoreErrors.errorDocumentNotExists,
        );
      }

      // Get data for update
      final _data = _updateObj.values.elementAt(i);

      // Update it
      _batch.update(_ref, _data);
    }

    await _batch.commit();
  }

  // Update user category's history
  Future<void> updateUserCategoryHistory({
    required String categoryId,
  }) async {
    // Get current user
    final _currentUser = await _getCurrentUser();

    // Get current user's category history
    final _currentUserCategoryHistory = _currentUser.categoryHistory;

    const _categoryHistoryField = ModelProperties.userCategoryHistoryProperty;

    // Check if null or empty
    if (_currentUserCategoryHistory != null &&
        _currentUserCategoryHistory.isNotEmpty) {
      for (final categoryHistory in _currentUserCategoryHistory) {
        if (categoryHistory.categoryId == categoryId) {
          // Update times by one
          ++categoryHistory.times;

          // Copy entire modified list
          final _dataList = _currentUserCategoryHistory
              .map((categoryHistory) => categoryHistory.toJson())
              .toList();

          // Create update object
          final _newData = {
            _categoryHistoryField: _dataList,
          };

          return updateCurrentUser(
            newData: _newData,
          );
        }
      }
    }

    // Create new category history model
    final _data = UserCategoryHistory(
      categoryId: categoryId,
    );

    // Cast to list to paste in arrayUnion
    final _dataList = [_data.toJson()];

    // Atomically add new categoryHistory to the "categoryHistory" array field.
    final _newData = {
      _categoryHistoryField: FieldValue.arrayUnion(_dataList),
    };

    return updateCurrentUser(
      newData: _newData,
    );
  }

  // Update user category's history
  Future<void> updateUserKeywordHistory({
    required String postId,
  }) async {
    final _currentUser = await _getCurrentUser();

    // Get user's keyword history
    final _currentUserKeywordHistory = _currentUser.keywordHistory;

    const _keywordHistoryField = ModelProperties.userKeywordHistoryProperty;

    // Get junction list
    final _junctionList = await _getJunctionKeywordPostByPostId(postId: postId);

    if (_junctionList.isEmpty) {
      throw Exception('Post has no keyword!');
    }

    // Get keywordId list
    final _keywordIdList =
        _junctionList.map((junction) => junction.keywordId).toList();

    // Check if null or empty
    if (_currentUserKeywordHistory != null &&
        _currentUserKeywordHistory.isNotEmpty) {
      // Copy _currentUserKeywordHistory list for comparison later
      final _cloneCurrentUserKeywordHistory = _currentUserKeywordHistory
          .map((item) => UserKeywordHistory.clone(item))
          .toList();

      // For each keyword history of current user
      for (final keywordHistory in _currentUserKeywordHistory) {
        // For each keywordId of given post
        for (final keywordId in _keywordIdList) {
          // If keywordId has existed in _currentUserKeywordHistory list
          if (keywordHistory.keywordId == keywordId) {
            // Update times by one
            ++keywordHistory.times;
            break;
          }
        }
      }

      // Check if any item of _currentUserKeywordHistory list has changed
      final _isNotChanged = const IterableEquality<UserKeywordHistory>()
          .equals(_currentUserKeywordHistory, _cloneCurrentUserKeywordHistory);

      // If some item has changed
      if (_isNotChanged == false) {
        // Then copy entire modified list
        final _dataList = _currentUserKeywordHistory
            .map((keywordHistory) => keywordHistory.toJson())
            .toList();

        final _newData = {
          _keywordHistoryField: _dataList,
        };

        return updateCurrentUser(
          newData: _newData,
        );
      }
    }

    // Create new keyword history models
    final _dataList = _keywordIdList
        .map((keywordId) => UserKeywordHistory(keywordId: keywordId).toJson())
        .toList();

    // Atomically add new categoryHistory to the "categoryHistory" array field.
    final _newData = {
      _keywordHistoryField: FieldValue.arrayUnion(_dataList),
    };

    return updateCurrentUser(
      newData: _newData,
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

  // Method to retrieve all Category Cards
  Stream<List<CategoryCard>> categoryCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.categoryCards(),
      builder: (data) => CategoryCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve all Popular Post Cards
  Stream<List<PostCard>> popularPostCardsStream() {
    const _viewField = ModelProperties.postCardViewProperty;

    const _defaultFilerField = _viewField;

    const _defaultOrderField = _viewField;

    const _numberOfDocumentToTake =
        AppFirestoreConstant.kHomeScreenPopularPostCardAmount;

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
  Stream<PostCard> postCardStream({
    required String postId,
  }) {
    return _fireStoreService.documentStream(
      path: FirestorePath.postCard(postId: postId),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
  }
}

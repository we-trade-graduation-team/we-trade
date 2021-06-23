import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import '../../constants/app_firestore_constant.dart';
import '../../models/cloud_firestore/category_card/category_card.dart';
import '../../models/cloud_firestore/category_events/category_events.dart';
import '../../models/cloud_firestore/junction_keyword_post/junction_keyword_post.dart';
import '../../models/cloud_firestore/junction_user_favorite_post/junction_user_favorite_post.dart';
import '../../models/cloud_firestore/junction_user_follower/junction_user_follower.dart';
import '../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../models/cloud_firestore/post_details_question/post_details_question.dart';
import '../../models/cloud_firestore/post_details_question_answer/post_details_question_answer.dart';
import '../../models/cloud_firestore/post_model/post/post.dart';
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

  // Method to retrieve info about current user
  Future<user_model.User> getUser({
    String? userId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.user(uid: userId ?? uid),
      builder: (data) => user_model.User.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to update current user info
  Future<void> updateCurrentUser({
    // required String uid,
    required Map<String, dynamic> newData,
  }) async {
    return _fireStoreService.updateData(
      path: FirestorePath.user(uid: uid),
      data: newData,
    );
  }

  // Method to update postCard info
  Future<void> _updatePostCard({
    required String postId,
    required Map<String, dynamic> newData,
  }) async {
    return _fireStoreService.updateData(
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

    await _updatePostCard(
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

  // Method to retrieve a Category Events
  Future<CategoryEvents> _getCategoryEvents({
    required String categoryId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.categoryEvents(categoryId: categoryId),
      builder: (data) => CategoryEvents.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve a List of Special Category Card
  Future<List<SpecialCategoryCard>> _getSpecialCategoryCardsWithLimit({
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
          return query
              .where(
                FieldPath.documentId,
                whereNotIn: excludedCategoryIdList,
              )
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
  Future<PostCard> getPostCard({
    required String postId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.postCard(postId: postId),
      builder: (data) => PostCard.fromDocumentSnapshot(data),
    );
    return _result;
  }

  // Method to retrieve a List of Post Card with a limit amount
  Future<List<PostCard>> _getPostCardsWithLimit({
    required int limit,
    String? fieldToOrder,
    List<String>? excludedPostIdList,
  }) async {
    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.postCards(),
      queryBuilder: (query) {
        // If has this argument
        if (excludedPostIdList != null && excludedPostIdList.isNotEmpty) {
          const _maxWhereNotInAmount =
              AppFirestoreConstant.whereNotInAmountMaximum;

          if (excludedPostIdList.length > _maxWhereNotInAmount) {
            ErrorHelper.throwArgumentError(
              message:
                  FirestoreErrors.errorWhereNotInMaximumUpToTenComparisonValues,
            );
          }

          return query
              .where(
                FieldPath.documentId,
                whereNotIn: excludedPostIdList,
              )
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

  // Method to retrieve a List of Junction Keyword Post by keywordId
  Future<List<JunctionKeywordPost>> _getJunctionKeywordPostListByKeywordId({
    required String keywordId,
    String? excludedPostId,
  }) async {
    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.junctionKeywordPost(),
      queryBuilder: (query) {
        const _keywordIdField = ModelProperties.keywordKeywordIdProperty;

        if (excludedPostId != null) {
          const _postIdField = ModelProperties.keywordPostIdProperty;

          return query
              .where(
                _keywordIdField,
                isEqualTo: keywordId,
              )
              .where(
                _postIdField,
                isNotEqualTo: excludedPostId,
              );
        }

        return query.where(
          _keywordIdField,
          isEqualTo: keywordId,
        );
      },
      builder: (data) => JunctionKeywordPost.fromDocumentSnapshot(data),
    );

    return _result;
  }

  // Method to retrieve a List of Junction Keyword Post by postId
  Future<List<JunctionKeywordPost>> _getJunctionKeywordPostListByPostId({
    required String postId,
  }) async {
    final _result = await _fireStoreService.collectionFuture(
      path: FirestorePath.junctionKeywordPost(),
      queryBuilder: (query) {
        const _filterField = ModelProperties.postCardIdProperty;

        return query.where(
          _filterField,
          isEqualTo: postId,
        );
      },
      builder: (data) => JunctionKeywordPost.fromDocumentSnapshot(data),
    );

    return _result;
  }

  // Method to retrieve a List of Post by userId
  Future<List<Post>> _getPostsByUserId({
    String? userId,
  }) async {
    return _fireStoreService.collectionFuture(
      path: FirestorePath.posts(),
      queryBuilder: (query) {
        const _ownerIdField = ModelProperties.postOwnerIdProperty;

        const _isHiddenField = ModelProperties.postIsHiddenProperty;

        return query
            .where(
              _ownerIdField,
              isEqualTo: userId ?? uid,
            )
            .where(
              _isHiddenField,
              isEqualTo: false,
            );
      },
      builder: (data) => Post.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve a List of Post not belong a user
  Future<List<Post>> _getPostsNotBelongToUser({
    String? userId,
    int? limit,
  }) async {
    return _fireStoreService.collectionFuture(
      path: FirestorePath.posts(),
      queryBuilder: (query) {
        const _ownerIdField = ModelProperties.postOwnerIdProperty;

        const _isHiddenField = ModelProperties.postIsHiddenProperty;

        if (limit != null) {
          return query
              .where(
                _ownerIdField,
                isNotEqualTo: userId ?? uid,
              )
              .where(
                _isHiddenField,
                isEqualTo: false,
              )
              .limit(limit);
        }

        return query
            .where(
              _ownerIdField,
              isNotEqualTo: userId ?? uid,
            )
            .where(
              _isHiddenField,
              isEqualTo: false,
            );
      },
      builder: (data) => Post.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve a List of postCard by userId
  Future<List<PostCard>> getPostCardsByUserId({
    String? userId,
  }) async {
    final _postsFromUser = await _getPostsByUserId(userId: userId);

    final _postIdList = _postsFromUser.map((post) => post.postId!).toList();

    final _result = await getPostCardsByPostIdList(postIdList: _postIdList);

    return _result;
  }

  // Method to retrieve a List of postCard by userId
  Future<List<PostCard>> _getPostCardsNotBelongToUser({
    String? userId,
    int? limit,
  }) async {
    final _postNotFromUser = await _getPostsNotBelongToUser(
      userId: userId,
      limit: limit,
    );

    final _postIdList = _postNotFromUser.map((post) => post.postId!).toList();

    final _result = await getPostCardsByPostIdList(postIdList: _postIdList);

    return _result;
  }

  // Method to retrieve a List of postCard by mainCategoryId
  Future<List<PostCard>> getPostCardsByMainCategoryId({
    required String mainCategoryId,
    int? limit,
    List<String>? excludedPostIdList,
  }) async {
    final _postsFromUser = await _fireStoreService.collectionFuture(
      path: FirestorePath.posts(),
      queryBuilder: (query) {
        const _mainCategoryIdField = ModelProperties.postMainCategoryIdProperty;

        const _isHiddenField = ModelProperties.postIsHiddenProperty;

        if (excludedPostIdList != null &&
            excludedPostIdList.isNotEmpty &&
            limit != null) {
          const _maxWhereNotInAmount =
              AppFirestoreConstant.whereNotInAmountMaximum;

          if (excludedPostIdList.length > _maxWhereNotInAmount) {
            ErrorHelper.throwArgumentError(
              message:
                  FirestoreErrors.errorWhereNotInMaximumUpToTenComparisonValues,
            );
          }

          return query
              .where(
                _mainCategoryIdField,
                isEqualTo: mainCategoryId,
              )
              .where(
                _isHiddenField,
                isEqualTo: false,
              )
              .where(
                FieldPath.documentId,
                whereNotIn: excludedPostIdList,
              )
              .limit(limit);
        }

        if (excludedPostIdList == null && limit != null) {
          return query
              .where(
                _mainCategoryIdField,
                isEqualTo: mainCategoryId,
              )
              .where(
                _isHiddenField,
                isEqualTo: false,
              )
              .limit(limit);
        }

        if (limit == null &&
            excludedPostIdList != null &&
            excludedPostIdList.isNotEmpty) {
          const _maxWhereNotInAmount =
              AppFirestoreConstant.whereNotInAmountMaximum;

          if (excludedPostIdList.length > _maxWhereNotInAmount) {
            ErrorHelper.throwArgumentError(
              message:
                  FirestoreErrors.errorWhereNotInMaximumUpToTenComparisonValues,
            );
          }

          return query
              .where(
                _mainCategoryIdField,
                isEqualTo: mainCategoryId,
              )
              .where(
                _isHiddenField,
                isEqualTo: false,
              )
              .where(
                FieldPath.documentId,
                whereNotIn: excludedPostIdList,
              );
        }

        return query
            .where(
              _mainCategoryIdField,
              isEqualTo: mainCategoryId,
            )
            .where(
              _isHiddenField,
              isEqualTo: false,
            );
      },
      builder: (data) => Post.fromDocumentSnapshot(data),
    );

    final _postIdList = _postsFromUser.map((post) => post.postId!).toList();

    final _result = await getPostCardsByPostIdList(postIdList: _postIdList);

    return _result;
  }

  // Method to retrieve a List of post card by a List of postId
  Future<List<PostCard>> getPostCardsByPostIdList({
    required List<String> postIdList,
  }) async {
    final _result = await Stream.fromIterable(postIdList)
        .asyncMap((postId) => getPostCard(postId: postId))
        .toList();

    return _result;
  }

  // Method to retrieve a List of Special Category Card
  // by a List of categoryId
  Future<List<SpecialCategoryCard>> _getSpecialCategoryCardsByCategoryIdList({
    required List<String> categoryIdList,
  }) async {
    final _result = await Stream.fromIterable(categoryIdList)
        .asyncMap(
            (categoryId) => _getSpecialCategoryCard(categoryId: categoryId))
        .toList();

    return _result;
  }

  // Method to retrieve a List of Special Category Card at Home Screen
  Future<List<SpecialCategoryCard>> getHomeScreenSpecialCategoryCards() async {
    final _currentUser = await getUser();

    // Get user's category history
    final _currentUserCategoryHistory = _currentUser.categoryHistory;

    const _numberOfDocumentToTake =
        AppFirestoreConstant.kHomeScreenSpecialCategoryCardAmount;

    // If null or empty
    if (_currentUserCategoryHistory == null ||
        _currentUserCategoryHistory.isEmpty) {
      final _result = await _getSpecialCategoryCardsWithLimit(
          limit: _numberOfDocumentToTake);

      return _result;
    }

    // Sort category history by times - descending
    _currentUserCategoryHistory.sort((a, b) => b.times.compareTo(a.times));

    // Get top times categoryId of user
    final _topCategoryIdList = _currentUserCategoryHistory
        .take(_numberOfDocumentToTake)
        .map((categoryHistory) => categoryHistory.categoryId)
        .toList();

    // Get special category cards according category Id
    final _specialCategoryCards =
        await _getSpecialCategoryCardsByCategoryIdList(
            categoryIdList: _topCategoryIdList);

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
    final _mostViewSpecialCategoryCards =
        await _getSpecialCategoryCardsWithLimit(
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

  // Method to retrieve a list of post cards that not belong to current user
  Future<List<PostCard>>
      _getPostCardsNotBelongToCurrentUserWithDeterminedAmount({
    required int amount,
  }) async {
    // Take top most view post cards (sort by view - default)
    final _postCardsWithMostView =
        await _getMostViewPostCardsNotBelongToCurrentUser(
      limit: amount,
    );

    // If take enough amount
    if (_postCardsWithMostView.length == amount) {
      return _postCardsWithMostView;
    }

    // Else take only _numberOfPostCardToTake amount
    final _result = _postCardsWithMostView.take(amount).toList();

    return _result;
  }

  // Method to retrieve a list of post cards that not belong to current user
  Future<List<PostCard>> _getMostViewPostCardsNotBelongToCurrentUser({
    required int limit,
  }) async {
    final _postCards = await _getPostCardsNotBelongToUser(limit: limit);

    _postCards.sort((a, b) => b.view.compareTo(a.view));

    return _postCards;
  }

  // Method to retrieve a List of Popular Post Card for Home Screen
  Future<List<PostCard>> getHomeScreenPopularPostCards() async {
    const _numberOfPostCardToTake =
        AppFirestoreConstant.kHomeScreenPopularPostCardAmount;

    final _result =
        await _getPostCardsNotBelongToCurrentUserWithDeterminedAmount(
      amount: _numberOfPostCardToTake,
    );

    return _result;
  }

  // Method to retrieve a List of postCard recommended for current user
  // at Home Screen
  Future<List<PostCard>> getHomeScreenRecommendedPostCards() async {
    final _currentUser = await getUser();

    // Get user's keyword history
    final _currentUserKeywordHistory = _currentUser.keywordHistory;

    // Amount of postCards to take
    const _numberOfPostCardToTake =
        AppFirestoreConstant.kHomeScreenRecommendedPostCardEachPullAmount;

    // Get current user's posts
    final _currentUserPosts = await _getPostsByUserId();

    // Get a list of postId from above list
    final _currentUserPostIdList =
        _currentUserPosts.map((post) => post.postId!).toList();

    // If null or empty
    if (_currentUserKeywordHistory == null ||
        _currentUserKeywordHistory.isEmpty) {
      final _result =
          await _getPostCardsNotBelongToCurrentUserWithDeterminedAmount(
        amount: _numberOfPostCardToTake,
      );

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

    // For each keywordId in _topKeyword, fetch all corresponding
    // junctionKeywordPost
    final _junctionsList = await Stream.fromIterable(_topKeyword)
        .asyncMap((keywordId) =>
            _getJunctionKeywordPostListByKeywordId(keywordId: keywordId))
        .toList();

    // Remove post cards that belong to current user
    for (final junctions in _junctionsList) {
      // This list contains junctions that should be remove later
      final _shouldRemoveJunction = <JunctionKeywordPost>[];

      // Check each junction in each junctions
      for (final junction in junctions) {
        // Get this junction's postId
        final _junctionPostId = junction.postId;
        // If this _junctionPostId is in _currentUserPostIdList
        if (_currentUserPostIdList.contains(_junctionPostId)) {
          // Add junction to should remove list
          _shouldRemoveJunction.add(junction);
          // // Remove it from junctions
          // junctions.remove(junction);
        }
      }

      junctions.removeWhere(_shouldRemoveJunction.contains);
    }

    // Equally divided the quantity of post cards for each keyword
    // Example: If user has less keyword than _numberOfKeywordToTake
    // then take only those keyword, otherwise take _numberOfKeywordToTake
    final _numberToDivide = _topKeyword.length < _numberOfKeywordToTake
        ? _topKeyword.length
        : _numberOfKeywordToTake;

    final _numberOfPostCardEachKeywordToTake =
        _numberOfPostCardToTake ~/ _numberToDivide;

    // A list contains items, each item is a list of post cards
    // getting from a list of junctionKeywordPost
    final _postCardsListBasedOnKeywordList =
        await Stream.fromIterable(_junctionsList).asyncMap((
      _junctions,
    ) async {
      final _postCardIdListFromJunction =
          _junctions.map((junction) => junction.postId).toList();

      // Fetch for each retrieved junction, fetch the associated postCard
      final _postCardsFromJunction = await getPostCardsByPostIdList(
        postIdList: _postCardIdListFromJunction,
      );

      // Sort descending by view
      _postCardsFromJunction.sort((a, b) => b.view.compareTo(a.view));

      // Get most view post card
      final _postCardToTake = _postCardsFromJunction
          .take(_numberOfPostCardEachKeywordToTake)
          .toList();

      return _postCardToTake;
    }).toList();

    // Flatten list
    final _flattenPostCardList = _postCardsListBasedOnKeywordList
        .expand((postCards) => postCards)
        .toList();

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
      final _mostViewPostCards = await _getPostCardsWithLimit(
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
    final _mostViewPostCardsExcludedFirstHalf = await _getPostCardsWithLimit(
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

  // Method to retrieve a List of similar postCards by postId
  // at postDetails screen
  Future<List<PostCard>> getPostDetailsScreenSimilarPostCards({
    required String postId,
  }) async {
    const _numberOfPostCardToTake =
        AppFirestoreConstant.kPostDetailsScreenSimilarPostCardsAmount;

    // Take a List of junction Keyword - Post corresponding to postId
    final _junctionListBasedOnPostId =
        await _getJunctionKeywordPostListByPostId(postId: postId);

    // Get a List of keywordId corresponding with above list
    final _keywordIdList = _junctionListBasedOnPostId
        .map((junction) => junction.keywordId)
        .toList();

    // For each keywordId in _keywordIdList, fetch all corresponding
    // junctionKeywordPost, except junction with this postId
    final _junctionsListBasedOnKeywordIdList =
        await Stream.fromIterable(_keywordIdList)
            .asyncMap(
              (keywordId) => _getJunctionKeywordPostListByKeywordId(
                keywordId: keywordId,
                excludedPostId: postId,
              ),
            )
            .toList();

    final _postCardsListBasedOnKeywordList =
        await Stream.fromIterable(_junctionsListBasedOnKeywordIdList).asyncMap((
      _junctions,
    ) async {
      final _postCardIdListFromJunction =
          _junctions.map((junction) => junction.postId).toList();

      // Fetch for each retrieved junction, fetch the associated postCard
      final _postCardsFromJunction = await getPostCardsByPostIdList(
        postIdList: _postCardIdListFromJunction,
      );

      return _postCardsFromJunction;
    }).toList();

    // Flatten list
    final _flattenPostCardList = _postCardsListBasedOnKeywordList
        .expand((postCards) => postCards)
        .toList();

    // Sort descending by view
    _flattenPostCardList.sort((a, b) => b.view.compareTo(a.view));

    // If has more than enough cards
    if (_flattenPostCardList.length > _numberOfPostCardToTake) {
      // Then take only _numberOfPostCardToTake
      final _result =
          _flattenPostCardList.take(_numberOfPostCardToTake).toList();

      return _result;
    }

    // Return if has enough cards
    if (_flattenPostCardList.length == _numberOfPostCardToTake) {
      return _flattenPostCardList;
    }

    const _maxWhereNotInAmount = AppFirestoreConstant.whereNotInAmountMaximum;

    // Check because similar postcards amount constants may be changed (> 10)!
    if (_flattenPostCardList.length >= _maxWhereNotInAmount) {
      throw Exception(
        FirestoreErrors
            .exceptionSimilarPostCardAmountGreaterThanConstantsAmount,
      );
    }

    // Calculate number of missing cards
    final _missingAmount =
        _numberOfPostCardToTake - _flattenPostCardList.length;

    // Retrieve post info from post id
    final _postInfo = await getPost(postId: postId);

    // Get main category id
    final _postMainCategoryId = _postInfo.categoryInfo.mainCategoryId;

    // Get postId from existing postCardList
    final _excludedPostIdList =
        _flattenPostCardList.map((postCard) => postCard.postId!).toList();

    // Also excluded this postId
    _excludedPostIdList.add(postId);

    final _excludedPostIdListLength = _excludedPostIdList.length;

    // Get postCards by main category id, with missing amount
    final _postCardsFromMainCategoryId = await getPostCardsByMainCategoryId(
      mainCategoryId: _postMainCategoryId,
      limit: _missingAmount + _excludedPostIdListLength,
      // excludedPostIdList: _excludedPostIdList,
    );

    // Remove post card that _excludedPostIdListLength contains its postId
    _postCardsFromMainCategoryId.removeWhere(
        (postCard) => _excludedPostIdList.contains(postCard.postId));

    // Sort descending by view
    _postCardsFromMainCategoryId.sort((a, b) => b.view.compareTo(a.view));

    final _postCardsFromMainCategoryIdLength =
        _postCardsFromMainCategoryId.length;

    if (_postCardsFromMainCategoryIdLength == _missingAmount) {
      // Concatenate two list
      final _fullList = [
        ..._flattenPostCardList,
        ..._postCardsFromMainCategoryId
      ];

      return _fullList;
    }

    // Take enough
    final _postCardsFromMainCategoryIdExactlyAmount =
        _postCardsFromMainCategoryId.take(_missingAmount).toList();

    // Concatenate two list
    final _fullList = [
      ..._flattenPostCardList,
      ..._postCardsFromMainCategoryIdExactlyAmount
    ];

    return _fullList;
  }

  // Method to retrieve a List of postCard that current user may also like
  // by postId at postDetails screen
  Future<List<PostCard>> getPostDetailsPostCardsCurrentUserMayAlsoLike() async {
    // Amount of postCards to take
    const _numberOfPostCardToTake = AppFirestoreConstant
        .kPostDetailsScreenPostCardsCurrentYouMayAlsoLikeEachPullAmount;

    // Take top most view post cards
    final _result =
        await _getPostCardsWithLimit(limit: _numberOfPostCardToTake);

    return _result;
  }

  // Method to increase view of category in all path by 1 (default)
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

    return _batch.commit();
  }

  // Method to update current user category's history
  Future<void> updateCurrentUserCategoryHistory({
    required String categoryId,
  }) async {
    // Get current user
    final _currentUser = await getUser();

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

  // Method to update current user category's history
  Future<void> updateCurrentUserKeywordHistory({
    required String postId,
  }) async {
    final _currentUser = await getUser();

    // Get user's keyword history
    final _currentUserKeywordHistory = _currentUser.keywordHistory;

    const _keywordHistoryField = ModelProperties.userKeywordHistoryProperty;

    // Get junction list
    final _junctionList =
        await _getJunctionKeywordPostListByPostId(postId: postId);

    if (_junctionList.isEmpty) {
      // If no have system keywords
      return;
      // throw Exception('Post has no keyword!');
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

  // Method to get post info by postId
  Future<Post> getPost({
    required String postId,
  }) async {
    final _result = await _fireStoreService.documentFuture(
      path: FirestorePath.post(postId: postId),
      builder: (data) => Post.fromDocumentSnapshot(data),
    );

    return _result;
  }

  // Method to retrieve uid of post Owner by postId
  Future<String> getPostOwnerId({
    required String postId,
  }) async {
    final _post = await getPost(postId: postId);

    return _post.owner;
  }

  // Method to check if a post is one of current user's favorites
  Future<bool> isFavoritePostOfCurrentUser({
    required String postId,
  }) async {
    final _result = await _fireStoreService.checkIfDocExists(
      path: FirestorePath.junctionUserFavoritePost(
        uid: uid,
        postId: postId,
      ),
    );

    return _result;
  }

  // Method to check if current user is a follower of an user
  Future<bool> isCurrentUserAFollowerOfUser({
    required String userId,
  }) async {
    final _result = await _fireStoreService.checkIfDocExists(
      path: FirestorePath.junctionUserFollower(
        uid: userId,
        followerId: uid,
      ),
    );

    return _result;
  }

  // Method to set new data at junction user favorite post collection
  Future<void> setJunctionUserFavoritePost({
    required String postId,
  }) async {
    final _junction = JunctionUserFavoritePost(
      uid: uid,
      postId: postId,
    );

    final _newData = _junction.toJson();

    return _fireStoreService.setData(
      path: FirestorePath.junctionUserFavoritePost(
        uid: uid,
        postId: postId,
      ),
      data: _newData,
    );
  }

  // Method to delete data at junction user favorite post collection
  Future<void> deleteJunctionUserFavoritePost({
    required String postId,
  }) async {
    return _fireStoreService.deleteData(
      path: FirestorePath.junctionUserFavoritePost(
        uid: uid,
        postId: postId,
      ),
    );
  }

  // Method to set new data at junction user follower collection
  Future<void> setJunctionUserFollower({
    required String postOwnerId,
  }) async {
    final _junction = JunctionUserFollower(
      uid: postOwnerId,
      followerId: uid,
    );

    final _newData = _junction.toJson();

    return _fireStoreService.setData(
      path: FirestorePath.junctionUserFollower(
        uid: postOwnerId,
        followerId: uid,
      ),
      data: _newData,
    );
  }

  // Method to delete data at junction user follower collection
  Future<void> deleteJunctionUserFollower({
    required String postOwnerId,
  }) async {
    return _fireStoreService.deleteData(
      path: FirestorePath.junctionUserFollower(
        uid: postOwnerId,
        followerId: uid,
      ),
    );
  }

  // Method to add a question
  Future<DocumentReference<Map<String, dynamic>>> addPostDetailsQuestion({
    required String postId,
    required String question,
  }) async {
    final _postDetailsQuestion = PostDetailsQuestion(
      askerId: uid,
      question: question,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    final _data = _postDetailsQuestion.toJson();

    return _fireStoreService.addData(
      path: FirestorePath.postQuestions(
        postId: postId,
      ),
      data: _data,
    );
  }

  // Method to add an answer
  Future<DocumentReference<Map<String, dynamic>>> addPostDetailsQuestionAnswer({
    required String postId,
    required String questionId,
    required String answer,
  }) async {
    final _postDetailsQuestionAnswer = PostDetailsQuestionAnswer(
      respondentId: uid,
      answer: answer,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    final _data = _postDetailsQuestionAnswer.toJson();

    return _fireStoreService.addData(
      path: FirestorePath.postQuestionAnswers(
        postId: postId,
        questionId: questionId,
      ),
      data: _data,
    );
  }

  // Method to retrieve a List of Category Card (Stream)
  Stream<List<CategoryCard>> categoryCardsStream() {
    return _fireStoreService.collectionStream(
      path: FirestorePath.categoryCards(),
      builder: (data) => CategoryCard.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve a List of postDetailsQuestion (Stream)
  Stream<List<PostDetailsQuestion>> postDetailsQuestionStream({
    required String postId,
  }) {
    return _fireStoreService.collectionStream(
      path: FirestorePath.postQuestions(
        postId: postId,
      ),
      builder: (data) => PostDetailsQuestion.fromDocumentSnapshot(data),
    );
  }

  // Method to retrieve a List of postDetailsQuestionAnswer (Stream)
  Stream<List<PostDetailsQuestionAnswer>> postDetailsQuestionAnswerStream({
    required String postId,
    required String questionId,
  }) {
    return _fireStoreService.collectionStream(
      path: FirestorePath.postQuestionAnswers(
        postId: postId,
        questionId: questionId,
      ),
      builder: (data) => PostDetailsQuestionAnswer.fromDocumentSnapshot(data),
    );
  }
}

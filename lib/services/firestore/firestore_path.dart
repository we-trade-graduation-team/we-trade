/*
This class defines all the possible read/write locations from the Firestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  FirestorePath._();

  static String users() => 'users';

  static String user({
    required String uid,
  }) =>
      '${users()}/$uid';

  static String userPostCards({
    required String uid,
  }) =>
      '${user(uid: uid)}/postCards';

  static String userSpecialOfferCards({
    required String uid,
  }) =>
      '${user(uid: uid)}/specialOfferCards';

  static String userRecommendedPostCards({
    required String uid,
  }) =>
      '${user(uid: uid)}/recommendedPostCards';

  static String userSearchHistory({
    required String uid,
  }) =>
      '${user(uid: uid)}/searchHistory';

  static String userFavoritePostCards({
    required String uid,
  }) =>
      '${user(uid: uid)}/favoritePostCards';

  // static String userPostCard({
  //   required String uid,
  //   required String postId,
  // }) =>
  //     'userPostCards/$uid/postCards/$postId';

  static String categoryCards() => 'categoryCards';
  
  static String specialOfferCards() => 'specialOfferCards';

  static String postCards() => 'postCards';

  static String postCard({
    required String postId,
  }) =>
      '${postCards()}/$postId';
}

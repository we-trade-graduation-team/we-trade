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

  static String categoryCards() => 'categoryCards';

  static String specialCategoryCards() => 'specialCategoryCards';

  static String specialCategoryCard({
    required String categoryId,
  }) =>
      '${specialCategoryCards()}/$categoryId';

  static String postCards() => 'postCards';

  static String postCard({
    required String postId,
  }) =>
      '${postCards()}/$postId';

  static String keywords() => 'keywords';

  static String keyword({
    required String keywordId,
  }) =>
      '${keywords()}/$keywordId';

  static String junctionKeywordPost() => 'junctionKeywordPost';
}

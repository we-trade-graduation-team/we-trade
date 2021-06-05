import 'package:algolia/algolia.dart';
import '../../models/ui/chat/temp_class.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';

class MessageServiceAlgolia {
  final Algolia algolia = Application.algolia;

  Future<List<AlgoliaObjectSnapshot>> searchUserByAlgolia(String query) {
    return algolia.instance
        .index(trangUsers)
        .query(query)
        .getObjects()
        .then((result) => result.hits);
  }

  Future<UserAlgolia> getUserById(String id) async {
    return algolia.instance
        .index(trangUsers)
        .object(id)
        .getObject()
        .then((value) {
      final user = UserAlgolia(
          id: id,
          name: value.data[nameStr].toString(),
          image: value.data[imageStr].toString(),
          email: value.data[emailStr].toString(),
          isActive: value.data[isActiveStr] as bool,
          activeAt: value.data[activeAtStr].toString());
      return user;
    });
  }
}

import 'package:algolia/algolia.dart';
import 'package:intl/intl.dart';

import '../../models/cloud_firestore/user/user.dart';
import '../../models/ui/chat/temp_class.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';
import 'firestore_message_service.dart';

class UserServiceAlgolia {
  final Algolia algolia = Application.algolia;

  Future<List<AlgoliaObjectSnapshot>> searchUserByAlgolia(String query) {
    return algolia.instance
        .index(trangUsersAlgoliaIndex)
        .query(query)
        .getObjects()
        .then((result) => result.hits);
  }

  Future<UserAlgolia> getUserById(String id) async {
    return algolia.instance
        .index(trangUsersAlgoliaIndex)
        .object(id)
        .getObject()
        .then((value) {
      final lastActive = DateFormat.yMd('en_US').add_jm().format(
          DateTime.fromMillisecondsSinceEpoch(
              int.parse(value.data[lastActiveStr].toString())));
      final user = UserAlgolia(
          id: id,
          name: value.data[nameStr].toString(),
          image: value.data[avatarURLStr].toString(),
          email: value.data[emailStr].toString(),
          isActive: value.data[presenceStr] as bool,
          activeAt: lastActive);
      return user;
    });
  }

  Map<String, dynamic> createUserMapAlgolia(User user) {
    return <String, dynamic>{
      'objectID': user.uid,
      emailStr: user.email,
      phoneNumberStr: user.phoneNumber ?? '',
      nameStr: user.displayName ?? '',
      presenceStr: user.presence ?? false,
      avatarURLStr: user.photoURL ?? '',
      lastActiveStr: user.lastSeen ?? 0
    };
  }

  //lúc sign up chỉ có 2 trường {name, email}
  Future<void> addUser(User newUser) async {
    final newUserMap = createUserMapAlgolia(newUser);
    await algolia.instance.index(trangUsersAlgoliaIndex).addObject(newUserMap);
  }

  //update nè :v
  Future<void> updateUser(User updateUser) async {
    final updateUserMap = createUserMapAlgolia(updateUser);
    final messageServiceFireStore = MessageServiceFireStore();
    await algolia.instance
        .index(trangUsersAlgoliaIndex)
        .object(updateUserMap['objectID'].toString())
        .updateData(updateUserMap);
    // ignore: unawaited_futures
    messageServiceFireStore.updateChatRoomsWhenUpdateUser(updateUser);
  }
}

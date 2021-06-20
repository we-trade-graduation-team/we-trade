import 'package:algolia/algolia.dart';
import 'package:intl/intl.dart';
import '../../models/cloud_firestore/user_model/user/user.dart';

import '../../models/ui/chat/temp_class.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../algolia/algolia.dart';
import 'firestore_message_service.dart';

class UserServiceAlgolia {
  final Algolia algolia = Application.algolia;

  Future<List<AlgoliaObjectSnapshot>> searchUserByAlgolia(String query) {
    return algolia.instance
        .index(usersAlgoliaIndex)
        .query(query)
        .getObjects()
        .then((result) => result.hits);
  }

  Future<UserAlgolia> getUserById(String id) async {
    return algolia.instance
        .index(usersAlgoliaIndex)
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
      nameStr: user.name ?? '',
      presenceStr: user.presence ?? false,
      avatarURLStr: user.avatarUrl ?? '',
      lastActiveStr: user.lastSeen ?? 0
    };
  }

  //lúc sign up chỉ có 2 trường {name, email}
  Future<void> addUser(User newUser) async {
    final newUserMap = createUserMapAlgolia(newUser);
    await algolia.instance.index(usersAlgoliaIndex).addObject(newUserMap);
  }

  //update nè :v
  Future<void> updateUser(User updateUser) async {
    final updateUserMap = createUserMapAlgolia(updateUser);
    final messageServiceFireStore = MessageServiceFireStore();
    await algolia.instance
        .index(usersAlgoliaIndex)
        .object(updateUserMap['objectID'].toString())
        .updateData(updateUserMap);
    // ignore: unawaited_futures
    messageServiceFireStore.updateChatRoomsWhenUpdateUser(updateUser);
  }
}

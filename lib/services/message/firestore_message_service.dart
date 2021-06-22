import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../models/ui/chat/temp_class.dart';
import '../../ui/message_features/const_string/const_str.dart';
import '../../ui/message_features/helper/ulti.dart';
import '../post_feature/post_service_firestore.dart';
import 'algolia_user_service.dart';

class MessageServiceFireStore {
  UserServiceAlgolia userServiceAlgolia = UserServiceAlgolia();

  Future<DocumentSnapshot<Map<String, dynamic>>> getChatRoomByChatRoomId(
      String chatRoomId) {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get();
  }

  Future<List<String>> getAllUsersIdInChatRoom(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get()
        .then((value) {
      return (value.get(usersIdStr) as List<dynamic>).cast<String>().toList();
    });
  }

  Future<void> createPeerToPeerChatRoomFireStore(
      Map<String, dynamic> chatData, String id) async {
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(id)
        .set(chatData, SetOptions(merge: true))
        .catchError((dynamic onError) {});
  }

  Future<String> createChatRoomGenerateIdFireStore(
      Map<String, dynamic> chatData) {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .add(chatData)
        .then((returnData) {
      return returnData.get().then((value) => value.id);
    });
  }

  Future<void> createSeenHistory(
      String chatRoomId, List<String> usersId) async {
    final mapData = <String, String>{};
    for (final element in usersId) {
      mapData[element] = '';
    }
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(seenHistoryCollection)
        .doc(chatRoomId)
        .set(mapData);
  }

  Future<void> addMessageToChatRoom(String senderId, int type,
      String contentToSend, String chatRoomId, String senderName) async {
    final mapData = <String, dynamic>{
      senderIdStr: senderId,
      messageStr: contentToSend,
      typeStr: type,
      timeStr: DateTime.now().millisecondsSinceEpoch
    };

    await addMessageToFireStore(chatRoomId, mapData).then((lastMessageId) {
      updateChatRoom(
          chatRoomId, contentToSend, senderId, senderName, type, lastMessageId);
    });
  }

  void updateChatRoom(String chatRoomId, String contentToSend, String senderId,
      String name, int type, String lastMessageId) {
    var lastMessage = '';
    switch (type) {
      case 0:
        lastMessage = contentToSend;
        break;
      case 1:
        lastMessage = 'Gửi một ảnh';
        break;
      case 2:
        lastMessage = 'Gửi một video';
        break;
      case 3:
        lastMessage = 'Gửi một clip thoại';
        break;

      default:
        lastMessage = '';
        break;
    }

    FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .update({
      lastMessageIdStr: lastMessageId,
      lastMessageStr: lastMessage,
      senderIdStr: senderId,
      senderNameStr: name,
      timeStr: DateTime.now().millisecondsSinceEpoch
    });
  }

  Future<String> addMessageToFireStore(
      String chatRoomId, Map<String, dynamic> mapData) async {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(chatCollection)
        .add(mapData)
        .then((value) => value.id);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChats(
      String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(chatCollection)
        .orderBy(timeStr, descending: true)
        .snapshots();
  }

  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getSeenHistory(
      String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(seenHistoryCollection)
        .doc(chatRoomId)
        .snapshots();
  }

  Future<void> updateMySeenHistory(
      String chatRoomId, String userId, String lastMessageId) async {
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(seenHistoryCollection)
        .doc(chatRoomId)
        .update({userId: lastMessageId});
  }

  Future<List<UserAlgolia>> getAllUserInChatRoom(String chatRoomId) {
    return getAllUsersIdInChatRoom(chatRoomId).then((usersId) async {
      final users = <UserAlgolia>[];
      for (final userid in usersId) {
        final user = await userServiceAlgolia.getUserById(userid);
        users.add(user);
      }
      return users;
    });
  }

  Future<Chat> getChatRoom(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get()
        .then((value) {
      return createChatFromData(value.data()!, value.id);
    });
  }

  Future<void> updateSeenHistoryOfChatRoom(
      String chatRoomId, String thisUserId, String lastMessageId) {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .collection(seenHistoryCollection)
        .doc(chatRoomId)
        .update({thisUserId: lastMessageId});
  }

  Chat createChatFromData(Map<String, dynamic> snapShot, String id) {
    var chatRoomName = '';
    if (snapShot[chatRoomNameStr].toString().isNotEmpty) {
      chatRoomName = snapShot[chatRoomNameStr].toString();
    } else {
      if (snapShot[groupChatStr] as bool) {
        chatRoomName = HelperClass.finalChatName(
            (snapShot[namesStr] as List<dynamic>).cast<String>().toList());
      }
    }
    final lastActive = DateFormat.yMd('en_US').add_jm().format(
        DateTime.fromMillisecondsSinceEpoch(
            int.parse(snapShot[timeStr].toString())));
    return Chat(
      chatRoomId: id,
      images: (snapShot[imagesStr] as List<dynamic>).cast<String>().toList(),
      lastMessage: snapShot[lastMessageStr].toString(),
      lastMessageId: snapShot[lastMessageIdStr].toString(),
      chatRoomName: chatRoomName,
      senderName: snapShot[senderNameStr].toString(),
      time: lastActive,
      senderId: snapShot[senderIdStr].toString(),
      usersId: (snapShot[usersIdStr] as List<dynamic>).cast<String>().toList(),
      names: (snapShot[namesStr] as List<dynamic>).cast<String>().toList(),
      emails: (snapShot[emailsStr] as List<dynamic>).cast<String>().toList(),
      groupChat: snapShot[groupChatStr] as bool,
    );
  }

  Future<void> outOfChatRoom(String chatRoomId, String userId) async {
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .get()
        .then((value) {
      final usersId =
          (value.data()![usersIdStr] as List<dynamic>).cast<String>().toList();
      final allImages =
          (value.data()![imagesStr] as List<dynamic>).cast<String>().toList();
      final allNames =
          (value.data()![namesStr] as List<dynamic>).cast<String>().toList();
      final allEmails =
          (value.data()![emailsStr] as List<dynamic>).cast<String>().toList();

      var thisUserName = '';
      for (var i = 0; i < usersId.length; i++) {
        if (usersId[i] == userId) {
          thisUserName = HelperClass.finalSenderName(allNames[i], allEmails[i]);
          usersId.removeAt(i);
          allImages.removeAt(i);
          allNames.removeAt(i);
          allEmails.removeAt(i);
          break;
        }
      }

      value.reference.update(<String, dynamic>{
        usersIdStr: usersId,
        imagesStr: allImages,
        namesStr: allNames,
        emailsStr: allEmails,
      });
      final contentToSend = '$thisUserName đã rời group';
      addMessageToChatRoom('', 0, contentToSend, chatRoomId, '');
    });
  }

  Future<void> changeGroupChatName(
      String chatRoomId, String newGroupName) async {
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .doc(chatRoomId)
        .update({chatRoomNameStr: newGroupName});
  }

  Future<void> addUsersToGroupChat(
    String chatRoomId,
    String myName,
    List<String> usersId,
    List<String> usersImage,
    List<String> usersEmail,
    List<String> usersName,
  ) async {
    var message = '$myName đã thêm ';
    await getChatRoom(chatRoomId).then((chatRoom) async {
      for (var i = 0; i < usersId.length; i++) {
        if (!chatRoom.usersId.contains(usersId[i])) {
          message += '${usersName[i]}, ';
          chatRoom.usersId.add(usersId[i]);
          chatRoom.images.add(usersImage[i]);
          chatRoom.emails.add(usersEmail[i]);
          chatRoom.names.add(usersName[i]);
        }
      }

      if (message != '$myName  đã thêm ') {
        //update data chatroom
        await FirebaseFirestore.instance
            .collection(chatRoomCollection)
            .doc(chatRoomId)
            .update({
          emailsStr: chatRoom.emails,
          namesStr: chatRoom.names,
          imagesStr: chatRoom.images,
          usersIdStr: chatRoom.usersId,
        });

        //add chat to chat room
        message = message.substring(0, message.length - 2);
        return addMessageToChatRoom('', 0, message, chatRoomId, '');
      }
    });
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllChatRooms(
      String userId) async {
    return FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .where(usersIdStr, arrayContains: userId)
        .orderBy(timeStr, descending: true)
        .snapshots();
  }

  Future<void> updateChatRoomsWhenUpdateUser(Map<String, dynamic> user) async {
    await FirebaseFirestore.instance
        .collection(chatRoomCollection)
        .where(usersIdStr, arrayContains: user['objectID'].toString())
        .get()
        .then((value) {
      for (final snapShot in value.docs) {
        final chat = createChatFromData(snapShot.data(), snapShot.id);
        for (var i = 0; i < chat.usersId.length; i++) {
          if (chat.usersId[i] == user['objectID'].toString()) {
            chat.images[i] = user['avatarUrl']!.toString();
            chat.names[i] = user['name']!.toString();
            chat.emails[i] = user['email']!.toString();
            break;
          }
        }

        snapShot.reference.update(<String, dynamic>{
          imagesStr: chat.images,
          namesStr: chat.names,
          emailsStr: chat.emails,
        });
      }
    });
  }

  Future<bool> isFollowUser(
      {required String thisUserId, required String userId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(thisUserId)
        .get()
        .then((user) {
      final allUsersId =
          (user.data()!['following'] as List<dynamic>).cast<String>().toList();
      return allUsersId.contains(userId);
    });
  }

  Future<UserDetail> getUserById({required String userId}) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((user) async {
      final data = user.data()!;
      final id = user.id;
      final name = getValueByKey(data, 'name') == null
          ? ''
          : getValueByKey(data, 'name').toString();
      final avatarUrl = getValueByKey(data, 'avatarUrl') == null
          ? userImageStr
          : getValueByKey(data, 'avatarUrl').toString();
      final phoneNumber = getValueByKey(data, 'phoneNumber') == null
          ? '0xx xxx xxx'
          : getValueByKey(data, 'phoneNumber').toString();
      final email = getValueByKey(data, 'email') == null
          ? 'no data'
          : getValueByKey(data, 'email').toString();
      final location = getValueByKey(data, 'location') == null
          ? 'no data'
          : getValueByKey(data, 'location').toString();
      final bio = getValueByKey(data, 'bio') == null
          ? '...'
          : getValueByKey(data, 'bio').toString();
      final legit = getValueByKey(data, 'legit') == null
          ? 0.0
          : double.parse(getValueByKey(data, 'legit').toString());
      final postsId = getValueByKey(data, 'posts') == null
          ? <String>[]
          : (getValueByKey(data, 'posts') as List<dynamic>)
              .cast<String>()
              .toList();
      final following = getValueByKey(data, 'following') == null
          ? 0
          : (getValueByKey(data, 'following') as List<dynamic>).length;
      final reviews = await getAllUserReviews(userId: userId);
      return UserDetail(
          id: id,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          bio: bio,
          legit: legit,
          location: location,
          following: following,
          phoneNumber: phoneNumber,
          reviews: reviews,
          postsId: postsId);
      // final reviewsId
    });
  }

  Future<List<Review>> getAllUserReviews({required String userId}) {
    return FirebaseFirestore.instance
        .collection('ratings')
        .where('userBeRated', isEqualTo: userId)
        .get()
        .then((result) async {
      final reviews = <Review>[];
      final userService = UserServiceAlgolia();
      final postService = PostServiceFireStore();
      for (final doc in result.docs) {
        final data = doc.data();
        final star = double.parse(data['star'].toString());
        final dateTime = (data['createAt'] as Timestamp).toDate();
        final user =
            await userService.getUserById(data['userMakeRating'].toString());
        final reply = data['reply'].toString();
        final comment = data['comment'].toString();
        var image = '';
        if (data['post'].toString().isNotEmpty) {
          image = await postService.getFirstPostImage(data['post'].toString());
        }
        reviews.add(Review(
          comment: comment,
          dateTime: dateTime,
          image: image,
          star: star,
          user: user,
          reply: reply,
        ));
      }
      return reviews;
    });
  }

  Future<void> handleFollowButton(
      {required String userId,
      required String thisUserId,
      required bool isAddFollowing}) async {
    await updateFollowingOrFollower(
        thisUserId: thisUserId,
        userId: userId,
        field: 'following',
        isAdding: isAddFollowing);
    await updateFollowingOrFollower(
        thisUserId: userId,
        userId: thisUserId,
        field: 'followers',
        isAdding: isAddFollowing);
  }

  Future<void> updateFollowingOrFollower(
      {required String thisUserId,
      required String userId,
      required String field,
      required bool isAdding}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(thisUserId)
        .get()
        .then((user) {
      final allUsersId =
          (user.data()![field] as List<dynamic>).cast<String>().toList();
      if (isAdding) {
        if (!allUsersId.contains(userId)) {
          allUsersId.add(userId);
        }
      } else {
        allUsersId.removeWhere((element) => element == userId);
      }
      user.reference.update({field: allUsersId});
    });
  }

  dynamic getValueByKey(Map<String, dynamic> map, String key) {
    if (map.containsKey(key)) {
      return map[key];
    } else {
      return null;
    }
  }
}

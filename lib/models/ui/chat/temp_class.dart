import 'package:flutter/cupertino.dart';

class Chat {
  Chat({
    required this.groupChat,
    required this.usersId,
    required this.names,
    required this.images,
    required this.emails,
    required this.chatRoomId,
    required this.chatRoomName,
    required this.lastMessage,
    required this.lastMessageId,
    required this.senderName,
    required this.senderId,
    required this.time,
    this.latestTrading,
  });

  Chat.nullChat()
      : chatRoomId = '',
        chatRoomName = '',
        emails = [],
        groupChat = false,
        images = [],
        lastMessage = '',
        lastMessageId = '',
        names = [],
        senderId = '',
        senderName = '',
        time = '',
        usersId = [],
        latestTrading = '';

  final String chatRoomId;
  final bool groupChat;
  final List<String> images, usersId, names, emails;
  final String chatRoomName;
  final String time;
  final String lastMessage, lastMessageId;
  final String senderName;
  final String senderId;
  final String? latestTrading;
}

@immutable
class UserAlgolia {
  const UserAlgolia({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
    required this.activeAt,
    required this.email,
  });

  final String name, image, activeAt, email;
  final bool isActive;
  final String id;

  @override
  bool operator ==(Object other) => other is UserAlgolia && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

class UserDetail {
  UserDetail(
      {required this.id,
      required this.name,
      required this.avatarUrl,
      required this.phoneNumber,
      required this.email,
      required this.location,
      required this.legit,
      required this.postsId,
      required this.following,
      required this.bio,
      required this.reviews});

  final String id;
  final String name;
  final String avatarUrl;
  final String phoneNumber;
  final String email;
  final String location;
  final double legit;
  final List<String> postsId;
  final int following;
  final String bio;
  final List<Review> reviews;
}

class Review {
  Review({
    required this.star,
    required this.dateTime,
    this.reply,
    required this.user,
    required this.comment,
    required this.image,
  });

  final String comment;
  final double star;
  final DateTime dateTime;
  final UserAlgolia user;

  final String image;
  final String? reply;
}

class Trading {
  Trading(
      {required this.id,
      required this.ownerId,
      required this.offerId,
      required this.ownerPost,
      required this.offerPosts,
      required this.status,
      required this.money,
      required this.isHaveMoney});

  Trading.nullTrading()
      : id = '',
        ownerId = '',
        offerId = '',
        ownerPost = '',
        offerPosts = [],
        status = 0,
        money = 0,
        isHaveMoney = false;

  final String id, ownerId, offerId;
  final String ownerPost;
  final List<String> offerPosts;
  final int status;
  final int money;
  final bool isHaveMoney;
}

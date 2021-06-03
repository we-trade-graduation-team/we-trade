import 'package:flutter/material.dart';

import '../review/temp_class.dart';

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
    required this.senderName,
    required this.senderId,
    required this.time,
  });

  Chat.nullChat()
      : chatRoomId = '',
        chatRoomName = '',
        emails = [],
        groupChat = false,
        images = [],
        lastMessage = '',
        names = [],
        senderId = '',
        senderName = '',
        time = '',
        usersId = [];

  final String chatRoomId;
  final bool groupChat;
  final List<String> images, usersId, names, emails;
  final String chatRoomName;
  final String time;
  final String lastMessage;
  final String senderName;
  final String senderId;
}

@immutable
class User {
  const User({
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
  bool operator ==(Object other) => other is User && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

class UserDetail {
  UserDetail(
      {required this.user,
      required this.phone,
      required this.email,
      required this.address,
      required this.legit,
      required this.postsNum,
      required this.followers,
      required this.userDescription,
      this.reviews});

  final User user;
  final String phone;
  final String email;
  final String address;
  final double legit;
  final int postsNum;
  final int followers;
  final String userDescription;
  final List<Review>? reviews;

  //final List<Post> posts;
  //final List<Review> reviews;
}

UserDetail userDetailTemp = UserDetail(
  user: usersData[0],
  phone: '0332087063',
  email: 'ngonhatrang99@gmail.com',
  address: '1xx nguyễn văn cừ, phường 5, quận 5, TP HCM ',
  legit: 4.8,
  postsNum: 10,
  followers: 20,
  userDescription:
      'hello mọi người, mong rằng chúng ta sẽ có giao dịch tốt , aloooooooooooooooooooooooooooooooooo ne :3',
  reviews: reviewsData,
);

List<User> usersData = [
  const User(
    id: 'ajhdkjfhakhfkjahdlkfahl',
    email: 'trang2@gmail.com',
    image:
        'https://media1.popsugar-assets.com/files/thumbor/cv5OP-R3W-eyDn0GcGLLCJJWLmg/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/06/19/950/n/1922153/1e5067d35d0aadb3e2ecf9.02908622_/i/Best-Celebrity-Makeup-Artists.jpg',
    name: 'Jenny Wilson',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  const User(
    id: '',
    email: 'trang3@gmail.com',
    image:
        'https://www.usmagazine.com/wp-content/uploads/2020/01/Kobe-Bryant-Dead-Shocking-Celebrity-Deaths.jpg?quality=86&strip=all',
    name: 'Esther Howard',
    isActive: true,
    activeAt: '',
  ),
  const User(
    id: '',
    email: 'trang3@gmail.com',
    image: '',
    name: 'Ralph Edwards',
    isActive: true,
    activeAt: '',
  ),
];

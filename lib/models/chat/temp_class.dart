import 'package:flutter/material.dart';

import '../review/temp_class.dart';

class Chat {
  Chat({
    required this.id,
    required this.users,
    required this.lastMessage,
    this.lastMessageByUser,
    this.chatName,
    required this.time,
  });

  int id;
  final String lastMessage, time;
  User? lastMessageByUser;
  String? chatName;
  final List<User> users;
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
  // User(
  //   image: 'https://miro.medium.com/max/1160/1*zqlxrm7WiivBu819S5pogA.jpeg',
  //   name: 'Jacob Jones',
  //   isActive: false,
  //   activeAt: 'active 3 mins ago',
  // ),
  // User(
  //   name: 'Albert Flores',
  //   image: '',
  //   isActive: false,
  //   activeAt: 'active 3 mins ago',
  // ),
  // User(
  //   image:
  //       'https://www.byrdie.com/thmb/rhEQ0zvDH2JFoggRbJlIjnhjxPU=/500x350/filters:no_upscale():max_bytes(150000):strip_icc()/cdn.cliqueinc.com__cache__posts__187408__celebrity-beauty-secrets-187408-1458276052-main.700x0c-cb101eda8d7f4941af00a9ca0e509c0d-915f519ce49e4ab69abe6052e59ae66b.jpg',
  //   name: 'Jenny Wilson',
  //   isActive: true,
  //   activeAt: '',
  // ),
  // User(
  //   image:
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9IxqYHaU0gttKuQINdt2HeMLlyjSNPC1FCpNS-0EiXHYRJi3qw97UPUsh11N4X8x5tNA&usqp=CAU',
  //   name: 'Esther Howard',
  //   isActive: true,
  //   activeAt: '',
  // ),
  // User(
  //   image:
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFs0uFjLm6UPlhIfXg7FBOIo5V-yRPmu4kyQ&usqp=CAU',
  //   name: 'Ralph Edwards',
  //   isActive: false,
  //   activeAt: 'active 3 mins ago',
  // ),
  // User(
  //   image:
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRSatTe40ZK_xdAe04u_7LDKlTA3P43dBcaw&usqp=CAU',
  //   name: 'Jacob Jones',
  //   isActive: true,
  //   activeAt: '',
  // ),
  // User(
  //   name: 'Albert Flores',
  //   image: '',
  //   isActive: false,
  //   activeAt: 'active 3 mins ago',
  // ),
];

List<Chat> chatsData = [
  // Chat(
  //   id: 0,
  //   users: [usersData[0], usersData[2]],
  //   lastMessage: 'Hope you are doing well...',
  //   lastMessageByUser: usersData[0],
  //   chatName: 'Group săn hàng',
  //   time: '3m ago',
  // ),
  // Chat(
  //   id: 1,
  //   users: [usersData[1]],
  //   lastMessage: 'Hello Abdullah! I am...',
  //   time: '8m ago',
  // ),
  // Chat(
  //   id: 2,
  //   users: [usersData[2]],
  //   lastMessage: 'Do you have update...',
  //   time: '5d ago',
  // ),
  // Chat(
  //   id: 3,
  //   users: [usersData[3]],
  //   lastMessage: 'You’re welcome :)',
  //   lastMessageByUser: usersData[3],
  //   time: '5d ago',
  // ),
  // Chat(
  //   id: 4,
  //   users: [usersData[4]],
  //   lastMessage: 'Thanks',
  //   time: '6d ago',
  // ),
  // Chat(
  //   id: 5,
  //   users: [usersData[8], usersData[9], usersData[4]],
  //   lastMessage: 'Hope you are doing well...',
  //   lastMessageByUser: usersData[5],
  //   time: '3m ago',
  // ),
  // Chat(
  //   id: 6,
  //   users: [usersData[1], usersData[2], usersData[3]],
  //   lastMessage: 'Hello Abdullah! I am...',
  //   chatName: 'Sample Group Chat',
  //   time: '8m ago',
  // ),
  // Chat(
  //   id: 7,
  //   users: [usersData[2]],
  //   lastMessage: 'Do you have update...',
  //   time: '5d ago',
  // ),
  // Chat(
  //   id: 8,
  //   users: [usersData[3]],
  //   lastMessage: 'Hope you are doing well...',
  //   lastMessageByUser: usersData[3],
  //   time: '3m ago',
  // ),
  // Chat(
  //   id: 9,
  //   users: [usersData[4]],
  //   lastMessage: 'Hello Abdullah! I am...',
  //   lastMessageByUser: usersData[4],
  //   time: '8m ago',
  // ),
  // Chat(
  //   id: 10,
  //   users: [usersData[0]],
  //   lastMessage: 'Do you have update...',
  //   time: '5d ago',
  // ),
  // Chat(
  //   id: 11,
  //   users: [usersData[1]],
  //   lastMessage: 'You’re welcome :)',
  //   time: '5d ago',
  // ),
  // Chat(
  //   id: 12,
  //   users: [usersData[2]],
  //   lastMessage: 'Thanks',
  //   time: '6d ago',
  // ),
];

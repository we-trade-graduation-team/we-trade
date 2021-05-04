import '../../configs/constants/assets_paths/shared_assets_root.dart';

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

class User {
  User({
    required this.name,
    required this.image,
    required this.isActive,
    required this.activeAt,
  });

  final String name, image, activeAt;
  final bool isActive;
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
  User(
    image: '$chatScreenAvaFolder/user.png',
    name: 'Jenny Wilson',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    image: '$chatScreenAvaFolder/user_2.png',
    name: 'Esther Howard',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: '$chatScreenAvaFolder/user_3.png',
    name: 'Ralph Edwards',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: '$chatScreenAvaFolder/user_4.png',
    name: 'Jacob Jones',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    name: 'Albert Flores',
    image: '$chatScreenAvaFolder/user_5.png',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    image: '$chatScreenAvaFolder/user.png',
    name: 'Jenny Wilson',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: '$chatScreenAvaFolder/user_2.png',
    name: 'Esther Howard',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: '$chatScreenAvaFolder/user_3.png',
    name: 'Ralph Edwards',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    image: '$chatScreenAvaFolder/user_4.png',
    name: 'Jacob Jones',
    isActive: true,
    activeAt: '',
  ),
  User(
    name: 'Albert Flores',
    image: '$chatScreenAvaFolder/user_5.png',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
];

List<Chat> chatsData = [
  Chat(
    id: 0,
    users: [usersData[0], usersData[2]],
    lastMessage: 'Hope you are doing well...',
    lastMessageByUser: usersData[0],
    chatName: 'Group săn hàng',
    time: '3m ago',
  ),
  Chat(
    id: 1,
    users: [usersData[1]],
    lastMessage: 'Hello Abdullah! I am...',
    time: '8m ago',
  ),
  Chat(
    id: 2,
    users: [usersData[2]],
    lastMessage: 'Do you have update...',
    time: '5d ago',
  ),
  Chat(
    id: 3,
    users: [usersData[3]],
    lastMessage: 'You’re welcome :)',
    lastMessageByUser: usersData[3],
    time: '5d ago',
  ),
  Chat(
    id: 4,
    users: [usersData[4]],
    lastMessage: 'Thanks',
    time: '6d ago',
  ),
  Chat(
    id: 5,
    users: [usersData[8], usersData[9], usersData[4]],
    lastMessage: 'Hope you are doing well...',
    lastMessageByUser: usersData[5],
    time: '3m ago',
  ),
  Chat(
    id: 6,
    users: [usersData[1], usersData[2], usersData[3]],
    lastMessage: 'Hello Abdullah! I am...',
    chatName: 'Sample Group Chat',
    time: '8m ago',
  ),
  Chat(
    id: 7,
    users: [usersData[2]],
    lastMessage: 'Do you have update...',
    time: '5d ago',
  ),
  Chat(
    id: 8,
    users: [usersData[3]],
    lastMessage: 'Hope you are doing well...',
    lastMessageByUser: usersData[3],
    time: '3m ago',
  ),
  Chat(
    id: 9,
    users: [usersData[4]],
    lastMessage: 'Hello Abdullah! I am...',
    lastMessageByUser: usersData[4],
    time: '8m ago',
  ),
  Chat(
    id: 10,
    users: [usersData[0]],
    lastMessage: 'Do you have update...',
    time: '5d ago',
  ),
  Chat(
    id: 11,
    users: [usersData[1]],
    lastMessage: 'You’re welcome :)',
    time: '5d ago',
  ),
  Chat(
    id: 12,
    users: [usersData[2]],
    lastMessage: 'Thanks',
    time: '6d ago',
  ),
];

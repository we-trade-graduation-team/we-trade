import '../review/temp_class.dart';

class Chat {
  Chat({
    required this.user,
    required this.lastMessage,
    required this.time,
  });

  final String lastMessage, time;
  final User user;
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
      required this.leggit,
      required this.postsNum,
      required this.followers,
      required this.userDesciption,
      this.reviews});

  final User user;
  final String phone;
  final String email;
  final String address;
  final double leggit;
  final int postsNum;
  final int followers;
  final String userDesciption;
  final List<Review>? reviews;

  //final List<Post> posts;
  //final List<Review> reviews;
}

UserDetail userDetailTemp = UserDetail(
  user: usersData[0],
  phone: '0332087063',
  email: 'ngonhatrang99@gmail.com',
  address: '1xx nguyễn văn cừ, phường 5, quận 5, TP HCM ',
  leggit: 4.8,
  postsNum: 10,
  followers: 20,
  userDesciption:
      'hello mọi người, mong rằng chúng ta sẽ có giao dịch tốt , aloooooooooooooooooooooooooooooooooo ne :3',
  reviews: reviewsData,
);

List<User> usersData = [
  User(
    image: 'assets/images/Chat_screen_ava_temp/user.png',
    name: 'Jenny Wilson',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user_2.png',
    name: 'Esther Howard',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user_3.png',
    name: 'Ralph Edwards',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user_4.png',
    name: 'Jacob Jones',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    name: 'Albert Flores',
    image: 'assets/images/Chat_screen_ava_temp/user_5.png',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user.png',
    name: 'Jenny Wilson',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user_2.png',
    name: 'Esther Howard',
    isActive: true,
    activeAt: '',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user_3.png',
    name: 'Ralph Edwards',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
  User(
    image: 'assets/images/Chat_screen_ava_temp/user_4.png',
    name: 'Jacob Jones',
    isActive: true,
    activeAt: '',
  ),
  User(
    name: 'Albert Flores',
    image: 'assets/images/Chat_screen_ava_temp/user_5.png',
    isActive: false,
    activeAt: 'active 3 mins ago',
  ),
];

List<Chat> chatsData = [
  Chat(
    user: usersData[0],
    lastMessage: 'Hope you are doing well...',
    time: '3m ago',
  ),
  Chat(
    user: usersData[1],
    lastMessage: 'Hello Abdullah! I am...',
    time: '8m ago',
  ),
  Chat(
    user: usersData[2],
    lastMessage: 'Do you have update...',
    time: '5d ago',
  ),
  Chat(
    user: usersData[2],
    lastMessage: 'You’re welcome :)',
    time: '5d ago',
  ),
  Chat(
    user: usersData[4],
    lastMessage: 'Thanks',
    time: '6d ago',
  ),
  Chat(
    user: usersData[0],
    lastMessage: 'Hope you are doing well...',
    time: '3m ago',
  ),
  Chat(
    user: usersData[1],
    lastMessage: 'Hello Abdullah! I am...',
    time: '8m ago',
  ),
  Chat(
    user: usersData[2],
    lastMessage: 'Do you have update...',
    time: '5d ago',
  ),
  Chat(
    user: usersData[3],
    lastMessage: 'Hope you are doing well...',
    time: '3m ago',
  ),
  Chat(
    user: usersData[4],
    lastMessage: 'Hello Abdullah! I am...',
    time: '8m ago',
  ),
  Chat(
    user: usersData[0],
    lastMessage: 'Do you have update...',
    time: '5d ago',
  ),
  Chat(
    user: usersData[1],
    lastMessage: 'You’re welcome :)',
    time: '5d ago',
  ),
  Chat(
    user: usersData[2],
    lastMessage: 'Thanks',
    time: '6d ago',
  ),
];

import '../detail_screen/user_rating_model.dart';

class Account {
  Account({
    required this.id,
    required this.avatar,
    required this.username,
    this.ratings,
  });

  final int id;
  final String avatar, username;
  final List<UserRating>? ratings;
}

List<Account> demoUsers = [
  Account(
    id: 1,
    username: 'Michael',
    avatar:
        'https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    ratings: [
      UserRating(
        title: 'Positive reviews',
        rating: 94,
      ),
      UserRating(
        title: 'On-time delivery',
        rating: 99,
      ),
      UserRating(
        title: 'Response rate',
        rating: 100,
      ),
    ],
  ),
  Account(
    id: 2,
    username: 'Shayna',
    avatar:
        'https://images.unsplash.com/photo-1499651681375-8afc5a4db253?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
    ratings: [
      UserRating(
        title: 'Positive reviews',
        rating: 94,
      ),
      UserRating(
        title: 'On-time delivery',
        rating: 51,
      ),
      UserRating(
        title: 'Response rate',
        rating: 20,
      ),
    ],
  ),
  Account(
    id: 3,
    username: 'Samantha',
    avatar:
        'https://images.unsplash.com/photo-1499651681375-8afc5a4db253?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
  ),
  Account(
    id: 4,
    username: 'Jack',
    avatar:
        'https://images.unsplash.com/photo-1499651681375-8afc5a4db253?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
  ),
  // User(
  //   id: 5,
  //   username: 'Samantha',
  //   avatar:
  //       'https://images.unsplash.com/photo-1499651681375-8afc5a4db253?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=987&q=80',
  // ),
];

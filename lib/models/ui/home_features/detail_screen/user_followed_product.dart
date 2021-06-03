class UserFollowedProduct {
  UserFollowedProduct({
    required this.userId,
    required this.followedProductId,
  });

  final int userId;
  final List<int> followedProductId;
}

List<UserFollowedProduct> demoUserFollowedProduct = [
  UserFollowedProduct(
    userId: 1,
    followedProductId: [1, 3, 5],
  ),
  UserFollowedProduct(
    userId: 2,
    followedProductId: [2, 4, 6],
  ),
];

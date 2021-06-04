import '../chat/temp_class.dart';
import '../product/temp_class.dart';

class Review {
  Review({
    required this.stars,
    required this.dateTime,
    this.replie,
    required this.user,
    required this.comment,
    required this.product,
  });

  final String comment;
  final double stars;
  final DateTime dateTime;
  final UserAlgolia user;

  final Product product;
  final String? replie;
}

List<Review> reviewsData = [
  Review(
    user: usersData[1],
    stars: 4.5,
    dateTime: DateTime.now(),
    product: productsData[0],
    comment:
        'sản phẩm tốt, giao dịch thân thiện nhanh gọn, nếu có sản phẩm nào khác phù hợp sẽ làm tiếp :3',
  ),
  Review(
    user: usersData[2],
    stars: 3,
    dateTime: DateTime.now(),
    product: productsData[1],
    replie: 'cảm ơn rất nhìu, chúc bạn ngày mới tốt lành',
    comment:
        'sản phẩm còn rất tốt, y như chính chủ mô tả, rất tốt, sẽ tiếp tục theo dõi',
  ),
];

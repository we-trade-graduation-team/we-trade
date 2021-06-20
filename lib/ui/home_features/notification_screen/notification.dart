class NotificationData{
  const NotificationData({
    required this.title,
    required this.content,
    required this.seen,
    required this.createAt,
    required this.followerId,
    required this.offererId,
    required this.postId,
    required this.type
  });

  final String title,content;
  final String postId,offererId,followerId;
  final bool seen;
  final int type;
  final String createAt;
}

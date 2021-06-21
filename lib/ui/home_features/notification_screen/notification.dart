class NotificationData{
  const NotificationData({
    required this.title,
    required this.content,
    required this.seen,
    required this.createAt,
    required this.followerId,
    required this.offererId,
    required this.postId,
    required this.type,
    required this.reason,
  });

  final String title,content,reason;
  final String postId,offererId,followerId;
  final bool seen;
  final int type;
  final String createAt;
}

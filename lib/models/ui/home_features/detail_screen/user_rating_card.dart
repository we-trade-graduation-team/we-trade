const numberOfUserRatingCard = 3;

class UserRatingCard {
  UserRatingCard({
    required this.positiveReviews,
    required this.onTimeDelivery,
    required this.responseRate,
  });

  final _UserRating positiveReviews;
  final _UserRating onTimeDelivery;
  final _UserRating responseRate;
  // final int numberOfRating;
}

class _UserRating {
  _UserRating({
    required this.title,
    this.rate = 0.0,
  });
  final String title;
  final double rate;
}

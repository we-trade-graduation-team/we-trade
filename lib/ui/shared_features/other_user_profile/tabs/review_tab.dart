import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/ui/chat/temp_class.dart';
import '../../../../widgets/review_card.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({Key? key, required this.reviews}) : super(key: key);

  final List<Review> reviews;

  @override
  _ReviewTabState createState() => _ReviewTabState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Review>('reviews', reviews));
  }
}

class _ReviewTabState extends State<ReviewTab> {
  @override
  Widget build(BuildContext context) {
    return widget.reviews.isNotEmpty
        ? ListView.builder(
            itemCount: widget.reviews.length,
            itemBuilder: (context, index) => ReviewCard(
              review: widget.reviews[index],
            ),
          )
        : const Center(child: Text('no data'));
  }
}

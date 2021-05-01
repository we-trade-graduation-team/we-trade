import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  // ignore: diagnostic_describe_all_properties
  final int maximumRating;
  // ignore: diagnostic_describe_all_properties
  final Function(int) onRatingSelected;

  RatingBar({required this.onRatingSelected, this.maximumRating = 5});

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _curentRating = 0;

  Widget _buildRatingStar(int index) {
    if (index < _curentRating) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          Icons.star,
          color: Colors.orange,
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          Icons.star_border_outlined,
        ),
      );
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(widget.maximumRating, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _curentRating = index + 1;
          });
          // print(_curentRating);
          widget.onRatingSelected(_curentRating);
        },
        child: _buildRatingStar(index),
      );
    });

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}

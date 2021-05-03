import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final Function(int) onRatingSelected;
  final int maximumRating;

  // ignore: sort_constructors_first
  const RatingBar({
    Key? key,
    required this.onRatingSelected,
    this.maximumRating = 5,
  }) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Function(int p1)>(
        'onRatingSelected', onRatingSelected));
    properties.add(IntProperty('maximumRating', maximumRating));
  }
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

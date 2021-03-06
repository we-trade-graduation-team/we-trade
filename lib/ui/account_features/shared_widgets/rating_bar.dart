import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyRatingBar extends StatefulWidget {
  const MyRatingBar({
    Key? key,
    required this.onRatingSelected,
    this.maximumRating = 5,
  }) : super(key: key);

  final Function(int) onRatingSelected;
  final int maximumRating;

  @override
  _MyRatingBarState createState() => _MyRatingBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Function(int p1)>(
        'onRatingSelected', onRatingSelected));
    properties.add(IntProperty('maximumRating', maximumRating));
  }
}

class _MyRatingBarState extends State<MyRatingBar> {
  int _currentRating = 0;

  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
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
          color: Colors.grey,
        ),
      );
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(widget.maximumRating, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });
          // print(_currentRating);
          widget.onRatingSelected(_currentRating);
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

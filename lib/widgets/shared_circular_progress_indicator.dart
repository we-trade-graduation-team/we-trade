import 'package:flutter/material.dart';

class SharedCircularProgressIndicator extends StatelessWidget {
  const SharedCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

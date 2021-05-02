import 'package:flutter/material.dart';
import '../../widgets/input_chat.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Align(
          alignment: Alignment.bottomLeft,
          child: ChatInput(),
        ),
      ],
    );
  }
}

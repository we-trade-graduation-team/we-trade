import 'package:flutter/material.dart';
import '../../widgets/input_chat.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

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

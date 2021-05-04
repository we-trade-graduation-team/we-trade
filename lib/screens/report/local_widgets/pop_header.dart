import 'package:flutter/material.dart';

class PopHeader extends StatelessWidget {
  const PopHeader({Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.black12,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: ()=>Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}

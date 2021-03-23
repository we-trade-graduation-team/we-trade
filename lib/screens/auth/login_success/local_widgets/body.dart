import 'package:flutter/material.dart';

import '../../../../configs/constants/assets_path.dart';
import '../../../../configs/constants/strings.dart';
import '../../../../widgets/default_button.dart';
import '../../../home/home_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.06),
            Image.asset(
              successImage,
              height: size.height * 0.4, //40%
            ),
            SizedBox(height: size.height * 0.08),
            const Text(
              kLoginSuccessTitle,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            DefaultButton(
              text: kLoginSuccessButton,
              press: () {
                Navigator.pushNamed(
                  context,
                  HomeScreen.routeName,
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

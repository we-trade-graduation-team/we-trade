import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/assets_path.dart';
import '../../../configs/constants/color.dart';
import '../../../configs/constants/keys.dart';
import '../../../configs/constants/strings.dart';
import '../../../widgets/default_button.dart';
import '../../welcome/welcome.dart';
import 'onboarding_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> walkThroughData = [
    {'text': kWalkThroughMessage_1, 'image': walkThroughImage_1},
    {'text': kWalkThroughMessage_2, 'image': walkThroughImage_2},
    {'text': kWalkThroughMessage_3, 'image': walkThroughImage_3},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: walkThroughData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  image: walkThroughData[index]['image']!,
                  text: walkThroughData[index]['text']!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        walkThroughData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: 'Continue',
                      press: () =>
                          Navigator.pushNamed(context, WelcomeScreen.routeName),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('currentPage', currentPage));
    properties.add(IterableProperty<Map<String, String>>(
        'walkThroughData', walkThroughData));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../configs/constants/assets_path.dart';
import '../../configs/constants/color.dart';
import '../../configs/constants/strings.dart';
import '../welcome_screen/welcome.dart';
// import '../../main_menu.dart';
// import '../home_screen/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
      ),
    );
    // Navigator.of(context).push<void>(
    //   MaterialPageRoute(
    //     builder: (_) => MainMenu(menuScreenContext: context),
    //   ),
    // );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    final walkThroughData = [
      {'text': kWalkThroughMessage_1, 'image': walkThroughImage_1},
      {'text': kWalkThroughMessage_2, 'image': walkThroughImage_2},
      {'text': kWalkThroughMessage_3, 'image': walkThroughImage_3},
    ];
    const bodyStyle = TextStyle(
      fontSize: 19,
      color: kTextLightColor,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: kPrimaryColor,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png', 100),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () => _onIntroEnd(context),
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
          ),
          child: const Text(
            "Let's go right away!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      pages: walkThroughData
          .map(
            (data) => PageViewModel(
              title: kAppTitle.toUpperCase(),
              body: data['text'],
              decoration: pageDecoration.copyWith(
                bodyFlex: 2,
                imageFlex: 4,
                bodyAlignment: Alignment.bottomCenter,
                imageAlignment: Alignment.topCenter,
              ),
              image: _buildImage(data['image']!),
              reverse: true,
            ),
          )
          .toList(),
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      color: kPrimaryColor,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12)
          : const EdgeInsets.fromLTRB(8, 4, 8, 4),
      dotsDecorator: const DotsDecorator(
        size: Size(10, 10),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22, 10),
        activeColor: kPrimaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<GlobalKey<IntroductionScreenState>>(
        'introKey', introKey));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../app_localizations.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import 'authentication_features/shared_widgets/authentication.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final walkThroughData = [
      {
        'text': _appLocalizations.translate('onBoardingTxtFirstMessage'),
        'image': AppAssets.firstWalkThroughImage
      },
      {
        'text': _appLocalizations.translate('onBoardingTxtSecondMessage'),
        'image': AppAssets.secondWalkThroughImage
      },
      {
        'text': _appLocalizations.translate('onBoardingTxtLastMessage'),
        'image': AppAssets.thirdWalkThroughImage
      },
    ];

    const bodyStyle = TextStyle(
      fontSize: 19,
      color: AppColors.kTextLightColor,
    );

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).primaryColor,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: _introKey,
      globalBackgroundColor: Colors.white,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: _onIntroEnd,
          // style: ElevatedButton.styleFrom(
          //   primary: Theme.of(context).primaryColor,
          // ),
          child: Text(
            _appLocalizations.translate('onBoardingBtnFooter'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      pages: walkThroughData
          .map(
            (data) => PageViewModel(
              title: _appLocalizations.translate('appTxtTitle').toUpperCase(),
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
      onDone: _onIntroEnd,
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text(
        _appLocalizations.translate('onBoardingTxtSkip'),
      ),
      next: const Icon(Icons.arrow_forward),
      done: Text(
        _appLocalizations.translate('onBoardingTxtDone'),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      color: Theme.of(context).primaryColor,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12)
          : const EdgeInsets.fromLTRB(8, 4, 8, 4),
      dotsDecorator: DotsDecorator(
        size: const Size(10, 10),
        color: const Color(0xFFBDBDBD),
        activeSize: const Size(22, 10),
        activeColor: Theme.of(context).primaryColor,
        activeShape: const RoundedRectangleBorder(
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

  void _onIntroEnd() {
    Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute(
        builder: (_) => const Authentication(),
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }
}

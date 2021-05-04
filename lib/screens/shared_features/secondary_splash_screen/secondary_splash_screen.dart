import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main_menu.dart';
import '../../guide_features/on_boarding_screen/on_boarding_screen.dart';
import '../../guide_features/welcome_screen/welcome.dart';

class SecondarySplashScreen extends StatefulWidget {
  const SecondarySplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SecondarySplashScreenState createState() => _SecondarySplashScreenState();
}

class _SecondarySplashScreenState extends State<SecondarySplashScreen> {
  Future checkFirstSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final _seen = prefs.getBool('seen') ?? false;

    await Future<void>.delayed(const Duration(seconds: 3));

    if (_seen) {
      await Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        ),
      );
    } else {
      await prefs.setBool('seen', true);
      await Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const lottieUrl =
        'https://assets9.lottiefiles.com/packages/lf20_l2kZFi.json';
    return FutureBuilder<void>(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: LayoutBuilder(
                builder: (_, constraints) => ListView(
                  shrinkWrap: true,
                  children: [
                    // Load a Lottie file from a remote url
                    Container(
                      padding: const EdgeInsets.all(20),
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Lottie.network(lottieUrl),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return MainMenu(menuScreenContext: context);
          }
        });
  }
}

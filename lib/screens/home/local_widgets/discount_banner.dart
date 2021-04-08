import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      // padding: EdgeInsets.symmetric(
      //   horizontal: size.width * 0.065,
      //   vertical: size.height * 0.03,
      // ),
      decoration: BoxDecoration(
        color: const Color(0xFFFEC200),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Positioned(
          //   top: 80,
          //   left: 0,
          //   child: ClipOval(
          //     child: Container(
          //       color: const Color(0xFFFFD54A),
          //       height: size.height * 0.15,
          //       width: size.width * 0.54,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 30,
          //   right: -80,
          //   child: ClipOval(
          //     child: Container(
          //       color: const Color(0xFFFFD54A),
          //       height: size.width * 0.64,
          //       width: size.width * 0.64,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.065,
              vertical: size.height * 0.03,
            ),
            child: Text.rich(
              TextSpan(
                style: const TextStyle(color: Colors.white),
                children: [
                  const TextSpan(
                    text: 'A New Surpise\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      height: size.height * 0.04,
                    ),
                  ),
                  const TextSpan(
                    text: 'Cashback 15%',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

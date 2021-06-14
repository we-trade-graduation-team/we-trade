import 'package:flutter/material.dart';

import '../../shared_widgets/custom_carousel_slider.dart';
import 'home_screen_special_event_banner.dart';

class HomeScreenSpecialEventCarouselSlider extends StatelessWidget {
  const HomeScreenSpecialEventCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final demoEventBanners = [
      HomeScreenSpecialEventBanner(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              const TextSpan(
                text: 'A New Surprise\n',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              WidgetSpan(
                child: SizedBox(height: size.height * 0.04),
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
      HomeScreenSpecialEventBanner(
        backgroundColor: Colors.amber,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              const TextSpan(
                text: 'Big sale is coming soon\n',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              WidgetSpan(
                child: SizedBox(height: size.height * 0.04),
              ),
              const TextSpan(
                text: "Don't worry",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      HomeScreenSpecialEventBanner(
        backgroundColor: Colors.red,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              const TextSpan(
                text: 'How much have you spent?\n',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              WidgetSpan(
                child: SizedBox(height: size.height * 0.04),
              ),
              const TextSpan(
                text: 'Trade more get more',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      HomeScreenSpecialEventBanner(
        backgroundColor: Colors.green,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              const TextSpan(
                text: 'New update\n',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              WidgetSpan(
                child: SizedBox(height: size.height * 0.04),
              ),
              const TextSpan(
                text: 'GET NOW',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    return CustomCarouselSlider(
      items: demoEventBanners,
      enableInfiniteScroll: false,
      autoPlay: true,
      width: size.width,
      dotColor: Colors.black87, // Inactive color
      dotActiveColor: Colors.white,
      // height: 414 - 56,
    );
  }
}

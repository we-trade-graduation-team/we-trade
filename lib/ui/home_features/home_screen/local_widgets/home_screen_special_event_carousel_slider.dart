import 'package:flutter/material.dart';

import '../../../../app_localizations.dart';
import '../../shared_widgets/custom_carousel_slider.dart';
import 'home_screen_special_event_banner.dart';

class HomeScreenSpecialEventCarouselSlider extends StatelessWidget {
  const HomeScreenSpecialEventCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    final _demoEventBanners = [
      HomeScreenSpecialEventBanner(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: _appLocalization.translate(
                    'homeScreenTxtSpecialEventBannerFirstSmallTitle'),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(text: '\n'),
              WidgetSpan(
                child: SizedBox(height: _size.height * 0.04),
              ),
              TextSpan(
                text: _appLocalization
                    .translate('homeScreenTxtSpecialEventBannerFirstBigTitle'),
                style: const TextStyle(
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
              TextSpan(
                text: _appLocalization.translate(
                    'homeScreenTxtSpecialEventBannerSecondSmallTitle'),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(text: '\n'),
              WidgetSpan(
                child: SizedBox(height: _size.height * 0.04),
              ),
              TextSpan(
                text: _appLocalization
                    .translate('homeScreenTxtSpecialEventBannerSecondBigTitle'),
                style: const TextStyle(
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
              TextSpan(
                text: _appLocalization.translate(
                    'homeScreenTxtSpecialEventBannerThirdSmallTitle'),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(text: '\n'),
              WidgetSpan(
                child: SizedBox(height: _size.height * 0.04),
              ),
              TextSpan(
                text: _appLocalization
                    .translate('homeScreenTxtSpecialEventBannerThirdBigTitle'),
                style: const TextStyle(
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
              TextSpan(
                text: _appLocalization.translate(
                    'homeScreenTxtSpecialEventBannerFourthSmallTitle'),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const TextSpan(text: '\n'),
              WidgetSpan(
                child: SizedBox(height: _size.height * 0.04),
              ),
              TextSpan(
                text: _appLocalization
                    .translate('homeScreenTxtSpecialEventBannerFourthBigTitle'),
                style: const TextStyle(
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
      items: _demoEventBanners,
      enableInfiniteScroll: false,
      autoPlay: true,
      width: _size.width,
      dotColor: Colors.black87, // Inactive color
      dotActiveColor: Colors.white,
      // height: 414 - 56,
    );
  }
}

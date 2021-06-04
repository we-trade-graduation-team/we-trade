import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../../app_localizations.dart';
import '../../../../utils/routes/routes.dart';

import '../../searching_screen/search_screen.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => pushNewScreenWithRouteSettings<void>(
        context,
        screen: const SearchScreen(),
        settings: const RouteSettings(name: Routes.searchScreenRouteName),
        withNavBar: false,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: size.width * 0.05,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
            const SizedBox(width: 15),
            Text(
              _appLocalizations.translate('homeScreenTxtAppBar'),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

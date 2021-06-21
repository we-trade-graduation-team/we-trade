import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache/shared_preference/shared_preference_helper.dart';
import 'flavor.dart';
import 'my_app.dart';
import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'providers/loading_overlay_provider.dart';
import 'providers/theme_provider.dart';
import 'services/firestore/firestore_database.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
        * MultiProvider for top services that do not depends on any runtime values
        * such as user uid/email.
       */
      MultiProvider(
        providers: [
          Provider<Flavor>.value(
            value: Flavor.prod,
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(
              SharedPreferenceHelper(
                SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
              FirebaseAuth.instance,
            ),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider(
              SharedPreferenceHelper(
                SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider<LoadingOverlayProvider>(
            create: (_) => LoadingOverlayProvider(),
          ),
        ],
        child: MyApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        ),
        // child: DevicePreview(
        //   enabled: !kReleaseMode,
        //   builder: (_) => MyApp(
        //     databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        //   ),
        // ),
      ),
    );
  });
}

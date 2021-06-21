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

// bool useFirestoreEmulator = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // if (useFirestoreEmulator) {
  //   FirebaseFirestore.instance.settings = const Settings(
  //     host: 'localhost:8080',
  //     sslEnabled: false,
  //     persistenceEnabled: false,
  //   );
  // }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) {
      final _sharedPreferenceHelper = SharedPreferenceHelper(
        SharedPreferences.getInstance(),
      );

      runApp(
        /*
          * MultiProvider for top services that do not depends on any runtime values
          * such as user uid/email.
        */
        MultiProvider(
          providers: [
            Provider<Flavor>.value(
              value: Flavor.dev,
            ),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(
                _sharedPreferenceHelper,
              ),
            ),
            ChangeNotifierProvider<LanguageProvider>(
              create: (_) => LanguageProvider(
                _sharedPreferenceHelper,
              ),
            ),
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(
                FirebaseAuth.instance,
              ),
            ),
            ChangeNotifierProvider<LoadingOverlayProvider>(
              create: (_) => LoadingOverlayProvider(),
            ),
          ],
          child: MyApp(
            databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
          ),
        ),
      );
    },
  );
}

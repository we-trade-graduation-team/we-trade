import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cloud_firestore/user/user.dart';
import 'providers/auth_provider.dart';
import 'services/firestore/firestore_database.dart';

/*
  * This class is mainly to help with creating user dependent object that
  * need to be available by all downstream widgets.
  * Thus, this widget builder is a must to live above [MaterialApp].
  * As we rely on uid to decide which main screen to display (eg: Home or Sign In),
  * this class will helps to create all providers needed that depends on
  * the user logged data uid.
 */
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({
    Key? key,
    required this.builder,
    required this.databaseBuilder,
  }) : super(key: key);

  final Widget Function(BuildContext, User?) builder;

  final FirestoreDatabase Function(BuildContext, String) databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthProvider>();

    return StreamProvider<User?>.value(
      initialData: null,
      value: authService.user,
      child: Consumer<User?>(
        builder: (_, user, __) {
          if (user != null) {
            /*
              * For any other Provider services that rely on user data can be
              * added to the following MultiProvider list.
              * Once a user has been detected, a re-build will be initiated.
            */
            return MultiProvider(
              providers: [
                Provider<User>.value(value: user),
                Provider<FirestoreDatabase>(
                  create: (context) => databaseBuilder(context, user.uid!),
                ),
              ],
              child: builder(context, user),
            );
          }
          return builder(context, user);
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<
            FirestoreDatabase Function(BuildContext context, String uid)>.has(
        'databaseBuilder', databaseBuilder));
    properties.add(
        ObjectFlagProperty<Widget Function(BuildContext p1, User? p2)>.has(
            'builder', builder));
  }
}

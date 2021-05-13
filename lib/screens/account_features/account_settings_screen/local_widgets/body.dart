import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../configs/constants/color.dart';
import '../../../../services/authentication/authentication_service.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 50,
              width: size.width,
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<AuthenticationService>().signOut();
                  await Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text('Sign out'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

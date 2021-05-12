import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../authentication_service.dart';

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
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                // style: ElevatedButton.styleFrom(),
                child: const Text('Sign out'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

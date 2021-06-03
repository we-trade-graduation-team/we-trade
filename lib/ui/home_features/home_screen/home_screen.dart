import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'local_widgets/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final user = context.watch<MyUser?>();

    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}

// abstract class Data {}

// class Content implements Data {
//   Content(this.data);

//   final List<String> data;
// }

// class Error implements Data {
//   Error(this.msg);

//   final String msg;
// }

// class Loading implements Data {
//   const Loading();
// }

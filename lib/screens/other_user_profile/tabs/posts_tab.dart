import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/chat/temp_class.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({Key? key, required this.userDetail}) : super(key: key);

  final UserDetail userDetail;
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        // child: Column(
        //   children: [],
        // ),
        );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/arguments/shared/post_details_arguments.dart';
import 'local_widgets/post_details_body.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as PostDetailsArguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.kScreenBackgroundColor,
      body: Provider<PostDetailsArguments>.value(
        value: _arguments,
        child: const PostDetailsBody(),
      ),
    );
  }
}

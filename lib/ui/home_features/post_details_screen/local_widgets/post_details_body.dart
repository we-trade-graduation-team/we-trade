import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'post_details_app_bar.dart';
import 'post_details_sections_box.dart';

class PostDetailsBody extends StatelessWidget {
  const PostDetailsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: [
        PostDetailsAppBar(),
        PostDetailsSectionsBox(),
      ],
    );
  }
}

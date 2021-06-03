import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/ui/chat/temp_class.dart';
import '../../../../widgets/review_card.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({Key? key, required this.userDetail}) : super(key: key);

  final UserDetail userDetail;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return ListView.builder(
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: userDetail.reviews!.length,
      itemBuilder: (context, index) => ReviewCard(
        review: userDetail.reviews![index],
        //press: () {},
        // press: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MessagesScreen(),
        //   ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}

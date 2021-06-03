import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/ui/chat/temp_class.dart';
// import '../../../../models/ui/shared_models/product_model.dart';
// import '../../../../widgets/item_post_card.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({Key? key, required this.userDetail}) : super(key: key);

  final UserDetail userDetail;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 20,
        runSpacing: 20,
        // TODO: <Trang> Replace List<Product> with List<PostCard>
        // children: [
        //   ...List.generate(
        //     allProduct.length,
        //     (index) {
        //       return ItemPostCard(postCard: allProduct[index]);
        //     },
        //   ),
        // ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}

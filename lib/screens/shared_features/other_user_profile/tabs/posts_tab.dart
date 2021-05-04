import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/chat/temp_class.dart';
import '../../../../models/shared_models/product_model.dart';
import '../../../../widgets/product_card.dart';

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
        children: [
          ...List.generate(
            allProduct.length,
            (index) {
              return ProductCard(product: allProduct[index]);
            },
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}

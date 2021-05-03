import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/shared_models/product_model.dart';
import 'detail_app_bar.dart';
import 'detail_sections_box.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        DetailAppBar(product: product),
        DetailSectionsBox(product: product),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

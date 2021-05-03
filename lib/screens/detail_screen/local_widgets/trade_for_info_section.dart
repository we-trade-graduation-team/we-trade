import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/shared_models/product_model.dart';
import 'detail_section_container.dart';
import 'detail_separator.dart';
import 'trade_for_category_preview.dart';

class TradeForInfoSection extends StatelessWidget {
  const TradeForInfoSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const DetailSectionContainer(
          height: 50,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.centerLeft,
            child: Text('Trade for'),
          ),
        ),
        DetailSeparator(height: size.height * 0.004),
        DetailSectionContainer(
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            // alignment: WrapAlignment.center,
            children: product.tradeForCategory
                .map((category) =>
                    TradeForCategoryPreview(tradeForCategory: category))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

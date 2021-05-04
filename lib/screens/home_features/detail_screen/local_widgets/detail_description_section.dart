import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../models/shared_models/product_model.dart';

import 'detail_section_container.dart';
import 'detail_separator.dart';

class DetailDescriptionSection extends StatelessWidget {
  const DetailDescriptionSection({
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
            child: Text('Description'),
          ),
        ),
        DetailSeparator(height: size.height * 0.004),
        Container(
          width: size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * kDetailHorizontalPaddingPercent,
            vertical: size.height * kDetailVerticalPaddingPercent,
          ),
          child: ExpandText(
            product.description,
            style: const TextStyle(fontWeight: FontWeight.w300),
            maxLines: 3,
            collapsedHint: 'Show more',
            expandedHint: 'Show less',
            hintTextStyle: const TextStyle(color: kPrimaryColor),
            arrowColor: kPrimaryColor,
            arrowSize: 24,
            expandArrowStyle: ExpandArrowStyle.both,
            capitalArrowtext: false,
            overflow: TextOverflow.ellipsis,
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

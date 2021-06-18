import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/ui/shared_models/product_model.dart';
import 'post_details_section_container.dart';
import 'post_details_separator.dart';

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
            horizontal: size.width * AppDimens.kDetailHorizontalPaddingPercent,
            vertical: size.height * AppDimens.kDetailVerticalPaddingPercent,
          ),
          child: ExpandText(
            product.description,
            style: const TextStyle(fontWeight: FontWeight.w300),
            maxLines: 3,
            collapsedHint: 'Show more',
            expandedHint: 'Show less',
            hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            arrowColor: Theme.of(context).primaryColor,
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

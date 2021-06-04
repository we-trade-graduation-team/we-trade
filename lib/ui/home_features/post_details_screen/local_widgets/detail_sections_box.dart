import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/ui/shared_models/product_model.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import 'detail_description_section.dart';
import 'detail_user_info_section.dart';
import 'faq_section.dart';
import 'seller_other_products_section.dart';
import 'similar_products_section.dart';
import 'title_section.dart';
import 'trade_for_info_section.dart';
import 'user_may_also_like_section.dart';

class DetailSectionsBox extends StatelessWidget {
  const DetailSectionsBox({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final detailChildren = [
      TitleSection(product: product),
      TradeForInfoSection(product: product),
      DetailDescriptionSection(product: product),
      DetailUserInfoSection(product: product),
      SellerOtherProductsSection(product: product),
      FaqSection(product: product),
      SimilarProductsSection(product: product),
      UserMayAlsoLikeSection(product: product),
    ];

    return SliverToBoxAdapter(
      child: CustomAnimationLimiterForListView<Widget>(
        scrollDirection: Axis.vertical,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        separatorHeight: size.height * 0.02,
        // separatorColor: Colors.transparent,
        duration: const Duration(
            milliseconds: AppDimens.kFlutterStaggeredAnimationsDuration ~/ 2),
        list: detailChildren,
        builder: (_, widget) => widget,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

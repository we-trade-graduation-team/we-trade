import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../configs/constants/keys.dart';
import '../../../../models/shared_models/product_model.dart';
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
      child: AnimationLimiter(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: detailChildren.length,
          itemBuilder: (_, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(
                  milliseconds: kFlutterStaggeredAnimationsDuration ~/ 2),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: detailChildren[index],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: size.height * 0.02,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

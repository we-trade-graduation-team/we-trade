import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/ui/home_features/detail_screen/user_rating_model.dart';
import '../../../../models/ui/shared_models/product_model.dart';
import '../../../../widgets/custom_animation_limiter_for_list_view.dart';
import '../../shared_widgets/rounded_outline_button.dart';
import 'post_details_follow_toggle_button.dart';
import 'post_details_section_container.dart';
import 'post_details_small_rating_thumbnail.dart';

class DetailUserInfoSection extends StatelessWidget {
  const DetailUserInfoSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          DetailSectionContainer(
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: size.height * 0.068,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            product.owner.avatar,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.owner.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Active 9 hours ag',
                          style: TextStyle(
                            fontSize: 13,
                            color: ((Theme.of(context).textTheme.bodyText2)!
                                    .color)!
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.075,
            child: Center(
              child: CustomAnimationLimiterForListView<UserRating>(
                scrollDirection: Axis.horizontal,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                separatorWidth: 35,
                duration: const Duration(
                    milliseconds:
                        AppDimens.kFlutterStaggeredAnimationsDuration ~/ 2),
                endIndent: size.height * 0.04,
                list: product.owner.ratings!,
                builder: (_, userRating) {
                  return SmallRatingThumbnail(
                    userRating: userRating,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FollowToggleButton(product: product),
                const SizedBox(width: 10),
                RoundedOutlineButton(
                  text: 'Profile',
                  borderColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                  press: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

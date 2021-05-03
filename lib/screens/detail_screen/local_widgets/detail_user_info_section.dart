import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../configs/constants/keys.dart';

import '../../../models/shared_models/product_model.dart';
import '../../../widgets/rounded_outline_button.dart';
import 'detail_section_container.dart';
import 'follow_toggle_button.dart';
import 'small_rating_thumbnail.dart';

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
              child: AnimationLimiter(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: product.owner.ratings!.length,
                  itemBuilder: (_, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(
                          milliseconds:
                              kFlutterStaggeredAnimationsDuration ~/ 2),
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: SmallRatingThumbnail(
                              userRating: product.owner.ratings![index]),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => VerticalDivider(
                    width: 35,
                    color: Colors.white,
                    endIndent: size.height * 0.04,
                  ),
                ),
              ),
              // child: ListViewWithSeparatorsBetween<UserRating>(
              //   direction: Axis.horizontal,
              //   items: product.owner.ratings!,
              //   itemBuilder: (_, item) =>
              //       SmallRatingThumbnail(userRating: item),
              //   separatorWidth: 35,
              //   endIndent: size.height * 0.04,
              // ),
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

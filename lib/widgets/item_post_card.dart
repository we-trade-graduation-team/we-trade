import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../models/arguments/shared/post_details_arguments.dart';
import '../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../models/ui/home_features/detail_screen/question_model.dart';
import '../models/ui/shared_models/account_model.dart';
import '../models/ui/shared_models/product_model.dart';
import '../ui/home_features/post_details_screen/post_details_screen.dart';
import '../utils/routes/routes.dart';

final tempProduct = Product(
  id: 1,
  images: [
    'https://images.unsplash.com/photo-1605899435973-ca2d1a8861cf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
    'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=598&q=80',
    'https://images.unsplash.com/photo-1529448155365-b176d2c6906b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80',
    'https://images.unsplash.com/photo-1529154691717-3306083d869e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
  ],
  tradeForCategory: tradeForList,
  title: 'Wireless Controller for PS4™ whole new level',
  price: 64.99,
  description: description,
  condition: condition,
  productLocation: location,
  ownerLocation: location,
  isFavourite: true,
  isPopular: true,
  owner: demoUsers[1],
  questions: demoQuestions,
);

class ItemPostCard extends StatelessWidget {
  const ItemPostCard({
    Key? key,
    required this.postCard,
  }) : super(key: key);

  final PostCard postCard;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => pushNewScreenWithRouteSettings<void>(
        context,
        screen: const PostDetailsScreen(),
        settings: RouteSettings(
          name: Routes.postDetailScreenRouteName,
          arguments: PostDetailsArguments(
            postCard: tempProduct,
          ),
        ),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      ),
      child: Container(
        // color: Colors.blue,
        width: 160,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  postCard.item.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        postCard.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        postCard.item.condition,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .color!
                                  .withOpacity(0.8),
                            ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 90,
                            child: Text(
                              '\$${postCard.item.price}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const Expanded(
                            flex: 8,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 42,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.5),
                              ),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  'District ${postCard.item.district}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PostCard>('postCard', postCard));
  }

  // String getProductLocationShortcutText(String productLocation) {
  //   final split = productLocation.split(',');
  //   final values = <int, String>{
  //     for (int i = 0; i < split.length; i++) i: split[i]
  //   };
  //   return values[0] != null ? values[0]! : 'Undefined';
  // }
}

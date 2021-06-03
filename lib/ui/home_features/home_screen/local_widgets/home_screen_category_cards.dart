import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/category_card/category_card.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'home_screen_category_card.dart';

class HomeScreenCategoryCards extends StatelessWidget {
  const HomeScreenCategoryCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.read<FirestoreDatabase>();

    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(size.width, size.height * 0.25)),
      child: Swiper(
        itemBuilder: (_, index) {
          return Center(
            child: StreamProvider<List<CategoryCard>>.value(
              initialData: const [],
              value: _firestoreDatabase.categoryCardsStream(),
              child: Consumer<List<CategoryCard>>(
                builder: (_, categoryCardList, __) {
                  return Wrap(
                    spacing: 5,
                    runSpacing: 15,
                    children: categoryCardList
                        .map(
                          (categoryCard) => HomeScreenCategoryCard(
                            categoryCard: categoryCard,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          );
        },
        pagination: const SwiperPagination(
          margin: EdgeInsets.all(5),
        ),
        itemCount: 2,
      ),
    );
  }
}

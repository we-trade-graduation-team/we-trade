import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/category_card/category_card.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'home_screen_category_cards.dart';

class HomeScreenCategoryCardsSection extends StatelessWidget {
  const HomeScreenCategoryCardsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        Size(
          _size.width,
          _size.height * 0.25,
        ),
      ),
      child: StreamProvider<List<CategoryCard>?>.value(
        initialData: null,
        value: _firestoreDatabase.categoryCardsStream(),
        catchError: (_, __) => const [],
        child: const HomeScreenCategoryCards(),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_card/post_card.dart';
import '../../../../models/cloud_firestore/search_model/search_model.dart';
import '../../../../models/cloud_firestore/user/user.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.postCard,
  }) : super(key: key);

  final PostCard postCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final textTheme = theme.textTheme;

    final model = context.read<SearchModel>();

    final user = context.read<User?>();

    late List<String> history;

    if (user != null) {
      history = user.searchHistory ?? [];
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            FloatingSearchBar.of(context)!.close();
            Future.delayed(
              const Duration(milliseconds: 500),
              model.clear,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : const Icon(Icons.place, key: Key('place')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postCard.title,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        postCard.itemCondition,
                        style: textTheme.bodyText2!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.suggestions.isNotEmpty && postCard != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PostCard>('postCard', postCard));
  }
}

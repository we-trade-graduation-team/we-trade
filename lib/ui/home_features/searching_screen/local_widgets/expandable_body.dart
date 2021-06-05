import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import '../../../../models/cloud_firestore/post_card_models/post_card/post_card.dart';

import '../../../../models/cloud_firestore/search_model/search_model.dart';
import 'item.dart';

class ExpandableBody extends StatelessWidget {
  const ExpandableBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SearchModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Material(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: ImplicitlyAnimatedList<PostCard>(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: model.suggestions.take(6).toList(),
          areItemsTheSame: (a, b) => a == b,
          itemBuilder: (_, animation, postCard, i) {
            return SizeFadeTransition(
              animation: animation,
              child: Item(postCard: postCard),
            );
          },
          updateItemBuilder: (_, animation, postCard) {
            return FadeTransition(
              opacity: animation,
              child: Item(postCard: postCard),
            );
          },
        ),
        // child: Builder(
        //   builder: (context) {
        //     if (_filteredSearchHistory.isEmpty && _controller.query.isEmpty) {
        //       return const InitialContent();
        //     } else if (_filteredSearchHistory.isEmpty) {
        //       return ListTile(
        //         title: Text(_controller.query),
        //         leading: const Icon(Icons.search),
        //         onTap: () => onSubmitted(_controller.query),
        //       );
        //     } else {
        //       return Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: _filteredSearchHistory
        //             .map(
        //               (term) => ListTile(
        //                 title: Text(
        //                   term,
        //                   maxLines: 1,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //                 leading: const Icon(Icons.history),
        //                 trailing: IconButton(
        //                   icon: const Icon(Icons.clear),
        //                   onPressed: () {
        //                     setState(() {
        //                       deleteSearchTerm(term);
        //                     });
        //                   },
        //                 ),
        //                 onTap: () {
        //                   setState(() {
        //                     putSearchTermFirst(term);
        //                     _selectedTerm = term;
        //                   });
        //                   _controller.close();
        //                 },
        //               ),
        //             )
        //             .toList(),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SearchModel>('model', model));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_details_question/post_details_question.dart';
import '../../../../providers/post_details_question_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_questions_section.dart';

class PostDetailsFaqSection extends StatelessWidget {
  const PostDetailsFaqSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postId = context.watch<String>();

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    return MultiProvider(
      providers: [
        StreamProvider<List<PostDetailsQuestion>>.value(
          initialData: const [],
          value: _firestoreDatabase.postDetailsQuestionStream(
            postId: _postId,
          ),
          catchError: (_, __) => const [],
        ),
        ChangeNotifierProvider(
          create: (_) => PostDetailsQuestionProvider(),
        )
      ],
      child: const PostDetailsQuestionsSection(),
    );
  }
}

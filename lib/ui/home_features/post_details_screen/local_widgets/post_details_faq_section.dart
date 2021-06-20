import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_details_model/post_details_question/post_details_question.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_questions_section.dart';

class PostDetailsFaqSection extends StatelessWidget {
  const PostDetailsFaqSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _postId = context.select<PostDetailsArguments, String>(
        (arguments) => arguments.postDetails.postId!);

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    return StreamProvider<List<PostDetailsQuestion>>.value(
      initialData: const [],
      value: _firestoreDatabase.postDetailsQuestionStream(
        postId: _postId,
      ),
      catchError: (_, __) => const [],
      child: const PostDetailsQuestionsSection(),
    );
  }
}

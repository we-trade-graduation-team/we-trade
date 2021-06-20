import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../models/cloud_firestore/post_details_model/post_details_question/post_details_question.dart';
import '../../../../models/cloud_firestore/post_details_model/post_details_question_answer/post_details_question_answer.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_question_column_answers_section.dart';
import 'post_details_to_vote_column.dart';

class PostDetailsQuestionColumn extends StatefulWidget {
  const PostDetailsQuestionColumn({
    Key? key,
    required this.question,
  }) : super(key: key);

  final PostDetailsQuestion question;

  @override
  _PostDetailsQuestionColumnState createState() =>
      _PostDetailsQuestionColumnState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<PostDetailsQuestion>('question', question));
  }
}

class _PostDetailsQuestionColumnState extends State<PostDetailsQuestionColumn> {
  @override
  Widget build(BuildContext context) {
    final _postId = context.select<PostDetailsArguments, String>(
        (arguments) => arguments.postDetails.postId!);

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _vote = widget.question.votes;

    final _size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostDetailsToVoteColumn(vote: _vote),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.question.question,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: _size.height * 0.02),
                  StreamProvider<List<PostDetailsQuestionAnswer>>.value(
                    initialData: const [],
                    value: _firestoreDatabase.postDetailsQuestionAnswerStream(
                      postId: _postId,
                      questionId: widget.question.questionId!,
                    ),
                    catchError: (_, __) => const [],
                    child: const PostDetailsQuestionColumnAnswersSection(),
                  )
                ],
              ),
            ),
          ],
        ),
        if (widget.question.answers!.length > 1)
          SizedBox(height: _size.height * 0.025),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_details_question/post_details_question.dart';
import '../../../../models/cloud_firestore/post_details_question_answer/post_details_question_answer.dart';
import '../../../../providers/post_details_question_provider.dart';
import '../../../../services/firestore/firestore_database.dart';
import 'post_details_question_column_answers_section.dart';

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
    final _postId = context.watch<String>();

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _questionProvider = context.watch<PostDetailsQuestionProvider>();

    final _questionId = _questionProvider.getPostQuestionId;

    final _buttonText =
        (_questionId != null && _questionId == widget.question.questionId)
            ? 'Cancel'
            : 'Answer';

    final _buttonStyle =
        (_questionId != null && _questionId == widget.question.questionId)
            ? ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.red,
              )
            : ElevatedButton.styleFrom(
                primary: Colors.deepPurple[400],
                onPrimary: Colors.white,
              );

    final _size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).primaryColorLight.withOpacity(0.2),
          padding: EdgeInsets.symmetric(
            horizontal: _size.width * 0.02,
            vertical: _size.height * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question: ${widget.question.question}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                onPressed: _onPressed,
                style: _buttonStyle,
                child: Text(_buttonText),
              ),
            ],
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
        ),
      ],
      // children: [
      //   Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // PostDetailsToVoteColumn(vote: _vote),
      //       const Expanded(child: SizedBox()),
      //       Expanded(
      //         flex: 18,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               widget.question.question,
      //               style: TextStyle(
      //                 color: Theme.of(context).primaryColor,
      //               ),
      //             ),
      //             SizedBox(height: _size.height * 0.02),
      //             StreamProvider<List<PostDetailsQuestionAnswer>>.value(
      //               initialData: const [],
      //               value: _firestoreDatabase.postDetailsQuestionAnswerStream(
      //                 postId: _postId,
      //                 questionId: widget.question.questionId!,
      //               ),
      //               catchError: (_, __) => const [],
      //               child: const PostDetailsQuestionColumnAnswersSection(),
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ],
    );
  }

  void _onPressed() {
    final _questionProvider = context.read<PostDetailsQuestionProvider>();

    final _questionId = widget.question.questionId;

    if (_questionProvider.getPostQuestionId == null ||
        _questionProvider.getPostQuestionId != _questionId) {
      _questionProvider.updatePostDetailsQuestionId(
        questionID: _questionId,
      );
    } else {
      _questionProvider.updatePostDetailsQuestionId(
        questionID: null,
      );
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/cloud_firestore/post_details_model/post_details_question_answer/post_details_question_answer.dart';

class PostDetailsAnswerColumn extends StatelessWidget {
  const PostDetailsAnswerColumn({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final PostDetailsQuestionAnswer answer;

  @override
  Widget build(BuildContext context) {
    final _date = DateTime.fromMillisecondsSinceEpoch(answer.createdAt);

    final _formattedDate = DateFormat.yMMMMd('en_US').format(_date);

    final _size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(answer.answer),
        SizedBox(height: _size.height * 0.01),
        Text(
          'By ${answer.respondentName} on $_formattedDate',
          style: TextStyle(
            color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                .withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<PostDetailsQuestionAnswer>('answer', answer));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_details_question_answer/post_details_question_answer.dart';
import 'post_details_answer_column.dart';
import 'post_details_no_items_section.dart';

class PostDetailsQuestionColumnAnswersSection extends StatefulWidget {
  const PostDetailsQuestionColumnAnswersSection({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsQuestionColumnAnswersSectionState createState() =>
      _PostDetailsQuestionColumnAnswersSectionState();
}

class _PostDetailsQuestionColumnAnswersSectionState
    extends State<PostDetailsQuestionColumnAnswersSection> {
  @override
  Widget build(BuildContext context) {
    final _answers = context.watch<List<PostDetailsQuestionAnswer>>();

    if (_answers.isEmpty) {
      final _appLocalization = AppLocalizations.of(context);

      return PostDetailsNoItemsSection(
          text: _appLocalization.translate('postDetailsTxtNoAnswers'));
    }

    final _size = MediaQuery.of(context).size;

    final _spacingHeight = _size.height * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            return PostDetailsAnswerColumn(
              answer: _answers[index],
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: _spacingHeight,
            color: Colors.transparent,
          ),
          itemCount: _answers.length,
        ),
      ],
    );
  }
}

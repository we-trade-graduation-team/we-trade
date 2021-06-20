import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_details_model/post_details_question_answer/post_details_question_answer.dart';
import '../../shared_widgets/rounded_outline_button.dart';
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

    return _answers.isNotEmpty
        ? buildAnswerColumn(_answers)
        : const PostDetailsNoItemsSection(text: 'No answers');
  }

  Widget buildAnswerColumn(List<PostDetailsQuestionAnswer> answers) {
    final _size = MediaQuery.of(context).size;

    final _spacingHeight = _size.height * 0.02;

    const _numberItemToShow = 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          _numberItemToShow,
          (index) => PostDetailsAnswerColumn(answer: answers[index]),
        ),
        SizedBox(height: _spacingHeight),
        if (answers.length > _numberItemToShow)
          ExpandChild(
            collapsedHint: 'Show more',
            expandedHint: 'Collapse all',
            hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            arrowColor: Theme.of(context).primaryColor,
            arrowSize: 24,
            arrowPadding: EdgeInsets.only(right: _size.width * 0.32),
            expandArrowStyle: ExpandArrowStyle.both,
            capitalArrowtext: false,
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    return PostDetailsAnswerColumn(
                        answer: answers[index + _numberItemToShow]);
                  },
                  separatorBuilder: (_, __) => Divider(
                    height: _spacingHeight,
                    color: Colors.transparent,
                  ),
                  itemCount: answers.length - _numberItemToShow,
                ),
              ],
            ),
          ),
        Align(
          alignment: Alignment.centerRight,
          child: RoundedOutlineButton(
            text: 'Answer',
            borderColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor,
            press: () {},
          ),
        ),
      ],
    );
  }
}

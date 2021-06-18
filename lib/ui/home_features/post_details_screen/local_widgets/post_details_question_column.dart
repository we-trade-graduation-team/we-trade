import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/ui/home_features/detail_screen/question_model.dart';
import '../../shared_widgets/rounded_outline_button.dart';
import 'post_details_answer_column.dart';
import 'post_details_no_items_section.dart';
import 'post_details_to_vote_column.dart';

class QuestionColumn extends StatefulWidget {
  const QuestionColumn({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  _QuestionColumnState createState() => _QuestionColumnState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Question>('question', question));
  }
}

class _QuestionColumnState extends State<QuestionColumn> {
  late int _vote;

  @override
  void initState() {
    super.initState();
    _vote = widget.question.voteNumber;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final answerList = widget.question.answers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            ToVoteColumn(vote: _vote),
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
                  SizedBox(height: size.height * 0.02),
                  if (answerList != null && answerList.isNotEmpty)
                    buildAnswerColumn()
                  else
                    const NoItemsSection(text: 'No answers')
                ],
              ),
            ),
          ],
        ),
        if (widget.question.answers!.length > 1)
          SizedBox(height: size.height * 0.025),
      ],
    );
  }

  Widget buildAnswerColumn() {
    final answerList = widget.question.answers!;
    final size = MediaQuery.of(context).size;
    final spacingHeight = size.height * 0.02;
    const numberItemToShow = 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          numberItemToShow,
          (index) => AnswerColumn(answer: answerList[index]),
        ),
        SizedBox(height: spacingHeight),
        if (answerList.length > numberItemToShow)
          ExpandChild(
            collapsedHint: 'Show more',
            expandedHint: 'Collapse all',
            hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            arrowColor: Theme.of(context).primaryColor,
            arrowSize: 24,
            arrowPadding: EdgeInsets.only(right: size.width * 0.32),
            expandArrowStyle: ExpandArrowStyle.both,
            capitalArrowtext: false,
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    return AnswerColumn(
                        answer: answerList[index + numberItemToShow]);
                  },
                  separatorBuilder: (_, __) => Divider(
                    height: spacingHeight,
                    color: Colors.transparent,
                  ),
                  itemCount: answerList.length - numberItemToShow,
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

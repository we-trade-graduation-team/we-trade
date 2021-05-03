import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../models/question_model.dart';
import '../../../widgets/rounded_outline_button.dart';
import 'answer_column.dart';
import 'no_items_section.dart';
import 'to_vote_column.dart';

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
  late int vote;

  @override
  void initState() {
    super.initState();
    vote = widget.question.voteNumber;
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
            Expanded(
              flex: 3,
              child: ToVoteColumn(vote: vote),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.question.question,
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                  SizedBox(height: size.height * 0.02),
                  if (answerList != null && answerList.isNotEmpty)
                    buildAnswerColumn(size)
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

  Widget buildAnswerColumn(Size size) {
    final answerList = widget.question.answers!;
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
            collapsedHint: 'Show more answers',
            expandedHint: 'Collapse all answers',
            hintTextStyle: const TextStyle(color: kPrimaryColor),
            arrowColor: kPrimaryColor,
            arrowSize: 24,
            arrowPadding: const EdgeInsets.only(right: 120),
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
            press: () {},
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('vote', vote));
  }
}

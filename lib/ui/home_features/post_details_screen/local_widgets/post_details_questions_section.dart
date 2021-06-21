import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_dimens.dart';
import '../../../../models/cloud_firestore/post_details_question/post_details_question.dart';
// import '../../../../providers/post_details_question_provider.dart';
import 'post_details_no_items_section.dart';
import 'post_details_question_column.dart';
import 'post_details_question_form.dart';

class PostDetailsQuestionsSection extends StatefulWidget {
  const PostDetailsQuestionsSection({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsQuestionsSectionState createState() =>
      _PostDetailsQuestionsSectionState();
}

class _PostDetailsQuestionsSectionState
    extends State<PostDetailsQuestionsSection> {
  @override
  Widget build(BuildContext context) {
    final _questions = context.watch<List<PostDetailsQuestion>>();

    // final _questionProvider = context.watch<PostDetailsQuestionProvider>();

    final _size = MediaQuery.of(context).size;

    return Container(
      width: _size.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * AppDimens.kDetailHorizontalPaddingPercent,
        vertical: _size.height * AppDimens.kDetailVerticalPaddingPercent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'faq'.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: _size.height * 0.025),
          const PostDetailsQuestionForm(),
          SizedBox(height: _size.height * 0.025),
          if (_questions.isNotEmpty)
            buildQuestionColumn(_questions)
          else
            const PostDetailsNoItemsSection(text: 'No questions')
        ],
      ),
    );
  }

  Widget buildQuestionColumn(List<PostDetailsQuestion> questions) {
    // questions.sort((a, b) => b.votes.compareTo(a.votes));

    final _size = MediaQuery.of(context).size;

    final _spacingHeight = _size.height * 0.025;

    // const numberItemToShow = 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            return PostDetailsQuestionColumn(
              question: questions[index],
            );
          },
          separatorBuilder: (_, __) => Divider(
            height: _spacingHeight,
            color: Colors.transparent,
          ),
          itemCount: questions.length,
        ),
      ],
      // children: [
      //   ...List.generate(
      //     numberItemToShow,
      //     (index) => PostDetailsQuestionColumn(question: questions[index]),
      //   ),
      //   SizedBox(height: _spacingHeight),
      //   if (questions.length > numberItemToShow)
      //     ExpandChild(
      //       collapsedHint: 'Show more questions',
      //       expandedHint: 'Collapse all questions',
      //       hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      //       arrowColor: Theme.of(context).primaryColor,
      //       arrowSize: 24,
      //       expandArrowStyle: ExpandArrowStyle.both,
      //       capitalArrowtext: false,
      //       child: Column(
      //         children: [
      //           ListView.separated(
      //             shrinkWrap: true,
      //             physics: const NeverScrollableScrollPhysics(),
      //             padding: EdgeInsets.zero,
      //             itemBuilder: (_, index) => PostDetailsQuestionColumn(
      //                 question: questions[index + numberItemToShow]),
      //             separatorBuilder: (_, __) => Divider(
      //               height: _spacingHeight,
      //               color: Colors.transparent,
      //             ),
      //             itemCount: questions.length - numberItemToShow,
      //           ),
      //         ],
      //       ),
      //     ),
      // ],
    );
  }
}

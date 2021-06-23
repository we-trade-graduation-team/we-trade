import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../constants/app_number_constants.dart';
import '../../../../models/cloud_firestore/post_details_question/post_details_question.dart';
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

    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    final _titleText =
        _appLocalization.translate('postDetailsTxtQuestionsSectionTitle');

    return Container(
      width: _size.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * AppNumberConstants.kDetailHorizontalPaddingPercent,
        vertical: _size.height * AppNumberConstants.kDetailVerticalPaddingPercent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _titleText.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: _size.height * 0.025),
          const PostDetailsQuestionForm(),
          SizedBox(height: _size.height * 0.025),
          if (_questions.isNotEmpty)
            buildQuestionColumn(_questions)
          else
            PostDetailsNoItemsSection(
                text: _appLocalization.translate('postDetailsTxtNoQuestions'))
        ],
      ),
    );
  }

  Widget buildQuestionColumn(List<PostDetailsQuestion> questions) {
    final _size = MediaQuery.of(context).size;

    final _spacingHeight = _size.height * 0.025;

    if (questions.isEmpty) {
      return Container();
    }

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
    );
  }
}

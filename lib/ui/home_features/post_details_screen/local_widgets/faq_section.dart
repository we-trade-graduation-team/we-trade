import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../models/ui/shared_models/product_model.dart';

import 'no_items_section.dart';
import 'question_column.dart';
import 'question_input_text_form_field.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final questionList = product.questions;
    return Container(
      width: size.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * AppDimens.kDetailHorizontalPaddingPercent,
        vertical: size.height * AppDimens.kDetailVerticalPaddingPercent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'faq'.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: size.height * 0.025),
          const QuestionInputTextFormField(),
          SizedBox(height: size.height * 0.025),
          if (questionList != null && questionList.isNotEmpty)
            buildQuestionColumn(context)
          else
            const NoItemsSection(text: 'No questions')
        ],
      ),
    );
  }

  Widget buildQuestionColumn(BuildContext context) {
    final questionList = product.questions!;
    questionList.sort((a, b) => b.voteNumber.compareTo(a.voteNumber));
    final size = MediaQuery.of(context).size;

    final spacingHeight = size.height * 0.025;
    const numberItemToShow = 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...List.generate(
          numberItemToShow,
          (index) => QuestionColumn(question: questionList[index]),
        ),
        SizedBox(height: spacingHeight),
        if (questionList.length > numberItemToShow)
          ExpandChild(
            collapsedHint: 'Show more questions',
            expandedHint: 'Collapse all questions',
            hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            arrowColor: Theme.of(context).primaryColor,
            arrowSize: 24,
            expandArrowStyle: ExpandArrowStyle.both,
            capitalArrowtext: false,
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) => QuestionColumn(
                      question: questionList[index + numberItemToShow]),
                  separatorBuilder: (_, __) => Divider(
                    height: spacingHeight,
                    color: Colors.transparent,
                  ),
                  itemCount: questionList.length - numberItemToShow,
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

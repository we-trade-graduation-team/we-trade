import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/ui/home_features/detail_screen/answer_model.dart';

import '../../../../models/ui/shared_models/account_model.dart';

class AnswerColumn extends StatelessWidget {
  const AnswerColumn({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    final userName =
        demoUsers.firstWhere((user) => user.id == answer.answerUserId).username;
    final date = DateFormat.yMMMMd('en_US').format(answer.date);
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(answer.answer),
        SizedBox(height: size.height * 0.01),
        Text(
          'By $userName on $date',
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
    properties.add(DiagnosticsProperty<Answer>('answer', answer));
  }
}

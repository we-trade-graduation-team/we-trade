import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/cloud_firestore/post_details_question_answer/post_details_question_answer.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../services/firestore/firestore_database.dart';
import '../../../../widgets/shared_circular_progress_indicator.dart';

class PostDetailsAnswerColumn extends StatelessWidget {
  const PostDetailsAnswerColumn({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final PostDetailsQuestionAnswer answer;

  @override
  Widget build(BuildContext context) {
    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    final _respondentId = answer.respondentId;

    final _date = DateTime.fromMillisecondsSinceEpoch(answer.createdAt);

    final _formattedDate = DateFormat.yMMMMd('en_US').format(_date);

    final _size = MediaQuery.of(context).size;

    final _appLocalization = AppLocalizations.of(context);

    final _answerTitleFirstPart =
        _appLocalization.translate('postDetailsTxEveryAnswerTitle');

    return Container(
      color: Theme.of(context).primaryColorLight.withOpacity(0.1),
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * 0.02,
        vertical: _size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$_answerTitleFirstPart: ${answer.answer}'),
          SizedBox(height: _size.height * 0.01),
          FutureProvider<User?>.value(
            value: _firestoreDatabase.getUser(
              userId: _respondentId,
            ),
            initialData: null,
            catchError: (_, __) => User.initialData(),
            child: Consumer<User?>(
              builder: (_, user, __) {
                if (user == null) {
                  return const SharedCircularProgressIndicator();
                }

                return Text(
                  'By ${user.name} on $_formattedDate',
                  style: TextStyle(
                    color: ((Theme.of(context).textTheme.bodyText2)!.color)!
                        .withOpacity(0.6),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<PostDetailsQuestionAnswer>('answer', answer));
  }
}

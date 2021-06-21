import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/cloud_firestore/post_details_question_answer/post_details_question_answer.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../services/firestore/firestore_database.dart';

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

    return Container(
      color: Theme.of(context).primaryColorLight.withOpacity(0.1),
      padding: EdgeInsets.symmetric(
        horizontal: _size.width * 0.02,
        vertical: _size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Answer: ${answer.answer}'),
          SizedBox(height: _size.height * 0.01),
          FutureProvider<User?>.value(
            value: _firestoreDatabase.getUser(
              userId: _respondentId,
            ),
            initialData: null,
            catchError: (_, __) => User.initialData(),
            child: Consumer<User?>(
              builder: (_, user, __) {
                return user == null
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Text(
                        'By ${user.name} on $_formattedDate',
                        style: TextStyle(
                          color:
                              ((Theme.of(context).textTheme.bodyText2)!.color)!
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

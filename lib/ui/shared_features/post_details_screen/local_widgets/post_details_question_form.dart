import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_localizations.dart';
import '../../../../models/arguments/shared/post_details_arguments.dart';
import '../../../../providers/loading_overlay_provider.dart';
import '../../../../providers/post_details_question_provider.dart';
import '../../../../services/firestore/firestore_database.dart';

class PostDetailsQuestionForm extends StatefulWidget {
  const PostDetailsQuestionForm({
    Key? key,
  }) : super(key: key);

  @override
  _PostDetailsQuestionFormState createState() =>
      _PostDetailsQuestionFormState();
}

class _PostDetailsQuestionFormState extends State<PostDetailsQuestionForm> {
  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _questionProvider = context.watch<PostDetailsQuestionProvider>();

    final _appLocalization = AppLocalizations.of(context);

    final _hintTextChooseKey = _questionProvider.questionId != null
        ? 'postDetailsTxtAnswerTextFormField'
        : 'postDetailsTxtQuestionTextFormField';

    final _hintTextChoose = _appLocalization.translate(_hintTextChooseKey);

    final _hintTextFirstPart =
        _appLocalization.translate('postDetailsTxtTextFormFieldHint');

    final _hintText = '$_hintTextFirstPart $_hintTextChoose';

    final _focusNode = FocusNode();

    final _inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            focusNode: _focusNode,
            controller: _textController,
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: _hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              border: _inputBorder,
              focusedBorder: _inputBorder,
              enabledBorder: _inputBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _appLocalization
                    .translate('postDetailsTxtTextFormFieldWarning');
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: _onPressed,
              child: Text(
                  _appLocalization.translate('postDetailsTxtButtonSubmit')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressed() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final _questionProvider = context.read<PostDetailsQuestionProvider>();

    final _questionId = _questionProvider.questionId;

    final _loadingOverlayProvider = context.read<LoadingOverlayProvider>();

    _loadingOverlayProvider.updateLoading(
      isLoading: true,
    );

    final _text = _textController.text;

    final _args = context.read<PostDetailsArguments>();

    final _postId = _args.postId;

    final _firestoreDatabase = context.read<FirestoreDatabase>();

    if (_questionId == null) {
      await _firestoreDatabase.addPostDetailsQuestion(
        postId: _postId,
        question: _text,
      );
    } else {
      await _firestoreDatabase.addPostDetailsQuestionAnswer(
        postId: _postId,
        questionId: _questionId,
        answer: _text,
      );

      _questionProvider.updatePostDetailsQuestionId(
        questionID: null,
      );
    }

    FocusScope.of(context).unfocus();

    _textController.clear();

    _loadingOverlayProvider.updateLoading(
      isLoading: false,
    );
  }
}

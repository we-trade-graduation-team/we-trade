import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    final _hintTextChoose =
        _questionProvider.questionId != null ? 'answer' : 'question';

    final _focusNode = FocusNode();

    // if (_questionProvider.questionId != null) {
    //   FocusScope.of(context).requestFocus(_focusNode);
    // }

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
              hintText: 'Type your $_hintTextChoose here',
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              border: _inputBorder,
              focusedBorder: _inputBorder,
              enabledBorder: _inputBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: _onPressed,
              child: const Text('Submit'),
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

    final _postId = context.read<String>();

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

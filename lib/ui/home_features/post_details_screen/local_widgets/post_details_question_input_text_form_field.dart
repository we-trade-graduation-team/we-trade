import 'package:flutter/material.dart';

class PostDetailsQuestionInputTextFormField extends StatelessWidget {
  const PostDetailsQuestionInputTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _inputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(8));

    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Type your question here',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: _inputBorder,
        focusedBorder: _inputBorder,
        enabledBorder: _inputBorder,
      ),
      // validator: FormValidator().validateEmail,
      // onSaved: (String value) {
      //   _loginData.email = value;
      // },
    );
  }
}

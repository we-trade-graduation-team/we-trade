import 'package:flutter/material.dart';

class QuestionInputTextFormField extends StatefulWidget {
  const QuestionInputTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  _QuestionInputTextFormFieldState createState() =>
      _QuestionInputTextFormFieldState();
}

class _QuestionInputTextFormFieldState
    extends State<QuestionInputTextFormField> {
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(8));
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Type your question here',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
      ),
      // validator: FormValidator().validateEmail,
      // onSaved: (String value) {
      //   _loginData.email = value;
      // },
    );
  }
}

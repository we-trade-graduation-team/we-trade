import '../../../models/authentication/authentication_error_content.dart';

final signUpDialogContents = {
  'email-already-in-use': AuthenticationErrorContent(
    title: 'Email already in-use',
    message: 'There already exists an account with the given email address.',
  ),
  'invalid-email': AuthenticationErrorContent(
    title: 'Invalid email',
    message: 'The email you entered is invalid. Please try again.',
  ),
  'operation-not-allowed': AuthenticationErrorContent(
    title: 'Operation not allowed',
    message: 'Email/password accounts are not enabled.',
  ),
  'weak-password': AuthenticationErrorContent(
    title: 'Weak password',
    message: 'The password is not strong enough. Please try again.',
  ),
};

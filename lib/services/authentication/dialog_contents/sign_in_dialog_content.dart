import '../../../models/authentication/authentication_error_content.dart';

final signInDialogContents = {
  'invalid-email': AuthenticationErrorContent(
    title: 'Invalid email',
    message: 'The email you entered is invalid. Please try again.',
  ),
  'wrong-password': AuthenticationErrorContent(
    title: 'Wrong password',
    message: 'The password you entered is incorrect. Please try again.',
  ),
  'user-not-found': AuthenticationErrorContent(
    title: 'User not found',
    message: 'There is no user corresponding to the given email.',
  ),
  'user-disabled': AuthenticationErrorContent(
    title: 'User disabled',
    message: 'This account is disabled',
  ),
};

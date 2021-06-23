import '../../../../app_localizations.dart';

class DialogContentHelper {
  DialogContentHelper(this._appLocalizations);

  final AppLocalizations _appLocalizations;

  Map<String, _AuthenticationErrorContent> get signInDialogContents => {
        'invalid-email': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorInvalidEmailTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorInvalidEmailContent'),
        ),
        'wrong-password': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorWrongPasswordTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorWrongPasswordContent'),
        ),
        'user-not-found': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorUserNotFoundTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorUserNotFoundContent'),
        ),
        'user-disabled': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorUserDisabledTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorUserDisabledContent'),
        ),
      };
  Map<String, _AuthenticationErrorContent> get signUpDialogContents => {
        'email-already-in-use': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorEmailAlreadyInUseTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorEmailAlreadyInUseContent'),
        ),
        'invalid-email': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorInvalidEmailTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorInvalidEmailContent'),
        ),
        'operation-not-allowed': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorOperationNotAllowedTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorOperationNotAllowedContent'),
        ),
        'weak-password': _AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorWeakPasswordTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorWeakPasswordContent'),
        ),
      };
}

class _AuthenticationErrorContent {
  _AuthenticationErrorContent({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
}

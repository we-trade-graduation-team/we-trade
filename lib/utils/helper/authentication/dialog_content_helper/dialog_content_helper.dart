import '../../../../app_localizations.dart';
import '../../../../models/ui/authentication_features/authentication_error_content.dart';

class DialogContentHelper {
  DialogContentHelper(this._appLocalizations);

  final AppLocalizations _appLocalizations;

  Map<String, AuthenticationErrorContent> get signInDialogContents => {
        'invalid-email': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorInvalidEmailTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorInvalidEmailContent'),
        ),
        'wrong-password': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorWrongPasswordTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorWrongPasswordContent'),
        ),
        'user-not-found': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorUserNotFoundTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorUserNotFoundContent'),
        ),
        'user-disabled': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('loginAlertTxtErrorUserDisabledTitle'),
          content: _appLocalizations
              .translate('loginAlertTxtErrorUserDisabledContent'),
        ),
      };
  Map<String, AuthenticationErrorContent> get signUpDialogContents => {
        'email-already-in-use': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorEmailAlreadyInUseTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorEmailAlreadyInUseContent'),
        ),
        'invalid-email': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorInvalidEmailTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorInvalidEmailContent'),
        ),
        'operation-not-allowed': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorOperationNotAllowedTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorOperationNotAllowedContent'),
        ),
        'weak-password': AuthenticationErrorContent(
          title: _appLocalizations
              .translate('registerAlertTxtErrorWeakPasswordTitle'),
          content: _appLocalizations
              .translate('registerAlertTxtErrorWeakPasswordContent'),
        ),
      };
}

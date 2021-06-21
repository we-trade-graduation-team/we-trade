class ErrorHelper {
  ErrorHelper._();

  static void throwArgumentError({
    required String message,
    String? path,
  }) {
    final _error = ArgumentError(message + (path ?? ''));
    throw _error;
  }
}
  
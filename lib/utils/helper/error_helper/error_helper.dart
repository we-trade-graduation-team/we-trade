class ErrorHelper {
  ErrorHelper._();

  static void throwArgumentError({
    required String message,
  }) {
    final _error = ArgumentError(message);
    throw _error;
  }
}

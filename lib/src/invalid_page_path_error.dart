class InvalidPagePathError extends Error {
  InvalidPagePathError(this.message, {this.suggestions})
      : assert(message != null);

  final String message;
  final String suggestions;
}

class RuntimeError extends Error {
  final String message;
  final String code;

  RuntimeError({required this.message, required this.code});
  factory RuntimeError.fromJson(Map json) => RuntimeError(message: json['message'], code: json['code']);

  @override
  String toString() {
    return 'Error: $message';
  }
}

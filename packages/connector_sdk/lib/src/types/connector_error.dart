class ConnectorError {
  final String id;
  final String docs;
  final String time;
  final String code;
  final String message;

  ConnectorError({required this.id, required this.docs, required this.time, required this.code, required this.message});

  factory ConnectorError.fromJson(Map<String, dynamic> json) {
    return ConnectorError(id: json['id'], docs: json['docs'], time: json['time'], code: json['code'], message: json['message']);
  }
}

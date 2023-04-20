import 'package:equatable/equatable.dart';

class LocalAttributeShareInfo extends Equatable {
  final String requestReference;
  final String peer;
  final String? sourceAttribute;

  const LocalAttributeShareInfo({
    required this.requestReference,
    required this.peer,
    this.sourceAttribute,
  });

  factory LocalAttributeShareInfo.fromJson(Map json) {
    return LocalAttributeShareInfo(
      requestReference: json['requestReference'],
      peer: json['peer'],
      sourceAttribute: json['sourceAttribute'],
    );
  }

  static LocalAttributeShareInfo? fromJsonNullable(Map? json) => json != null ? LocalAttributeShareInfo.fromJson(json) : null;

  Map<String, dynamic> toJson() => {
        'requestReference': requestReference,
        'peer': peer,
        if (sourceAttribute != null) 'sourceAttribute': sourceAttribute,
      };

  @override
  String toString() => 'LocalAttributeShareInfoJSON(requestReference: $requestReference, peer: $peer, sourceAttribute: $sourceAttribute)';

  @override
  List<Object?> get props => [requestReference, peer, sourceAttribute];
}

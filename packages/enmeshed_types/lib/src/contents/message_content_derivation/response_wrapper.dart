part of 'message_content_derivation.dart';

enum RequestSourceType { RelationshipTemplate, Message }

class ResponseWrapper extends MessageContentDerivation {
  final String requestId;
  final String requestSourceReference;
  final RequestSourceType requestSourceType;
  final Response response;

  const ResponseWrapper({
    required this.requestId,
    required this.requestSourceReference,
    required this.requestSourceType,
    required this.response,
  });

  factory ResponseWrapper.fromJson(Map json) {
    return ResponseWrapper(
      requestId: json['requestId'],
      requestSourceReference: json['requestSourceReference'],
      requestSourceType: RequestSourceType.values.byName(json['requestSourceType']),
      response: Response.fromJson(json['response']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '@type': 'ResponseWrapper',
      'requestId': requestId,
      'requestSourceReference': requestSourceReference,
      'requestSourceType': requestSourceType.name,
      'response': response.toJson(),
    };
  }

  @override
  List<Object?> get props => [requestId, requestSourceReference, requestSourceType, response];
}

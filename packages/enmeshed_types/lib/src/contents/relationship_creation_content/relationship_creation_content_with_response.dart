part of 'relationship_creation_content.dart';

class RelationshipCreationContentWithResponse extends RelationshipCreationContent {
  final Response response;

  const RelationshipCreationContentWithResponse({
    required this.response,
  });

  factory RelationshipCreationContentWithResponse.fromJson(Map json) => RelationshipCreationContentWithResponse(
        response: Response.fromJson(json['response']),
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      '@type': 'RelationshipCreationContent',
      'response': response.toJson(),
    };
  }

  @override
  List<Object?> get props => [response];
}

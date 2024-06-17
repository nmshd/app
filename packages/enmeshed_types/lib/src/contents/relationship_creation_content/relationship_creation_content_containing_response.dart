part of 'relationship_creation_content.dart';

class RelationshipCreationContentContainingResponse extends RelationshipCreationContent {
  final Response response;

  const RelationshipCreationContentContainingResponse({
    required this.response,
  });

  factory RelationshipCreationContentContainingResponse.fromJson(Map json) => RelationshipCreationContentContainingResponse(
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

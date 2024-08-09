part of 'relationship_creation_content_derivation.dart';

class RelationshipCreationContent extends RelationshipCreationContentDerivation {
  final Response response;

  const RelationshipCreationContent({
    required this.response,
  });

  factory RelationshipCreationContent.fromJson(Map json) => RelationshipCreationContent(
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

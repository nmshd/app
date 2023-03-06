part of 'relationship_change_request_content.dart';

class RelationshipCreationChangeRequestContent extends RelationshipChangeRequestContent {
  final Response response;

  RelationshipCreationChangeRequestContent({
    required this.response,
  });

  factory RelationshipCreationChangeRequestContent.fromJson(Map<String, dynamic> json) => RelationshipCreationChangeRequestContent(
        response: Response.fromJson(json['response']),
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      '@type': 'RelationshipCreationChangeRequestContent',
      'response': response.toJson(),
    };
  }
}

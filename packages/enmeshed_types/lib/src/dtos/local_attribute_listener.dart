import '../contents/contents.dart';

class LocalAttributeListenerDTO {
  final String id;
  final AttributeQuery query;
  final String peer;

  LocalAttributeListenerDTO({
    required this.id,
    required this.query,
    required this.peer,
  });

  factory LocalAttributeListenerDTO.fromJson(Map<String, dynamic> json) {
    return LocalAttributeListenerDTO(
      id: json['id'],
      query: AttributeQuery.fromJson(json['query']),
      peer: json['peer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'query': query.toJson(),
        'peer': peer,
      };

  @override
  String toString() => 'LocalAttributeListenerDTO(id: $id, query: $query, peer: $peer)';
}

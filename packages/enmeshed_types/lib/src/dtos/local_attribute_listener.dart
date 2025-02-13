import 'package:equatable/equatable.dart';

import '../contents/contents.dart';

class LocalAttributeListenerDTO extends Equatable {
  final String id;
  final AttributeQuery query;
  final String peer;

  const LocalAttributeListenerDTO({required this.id, required this.query, required this.peer});

  factory LocalAttributeListenerDTO.fromJson(Map json) {
    return LocalAttributeListenerDTO(id: json['id'], query: AttributeQuery.fromJson(json['query']), peer: json['peer']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'query': query.toJson(), 'peer': peer};

  @override
  List<Object?> get props => [id, query, peer];
}

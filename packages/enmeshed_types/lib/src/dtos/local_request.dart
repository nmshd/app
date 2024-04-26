import 'package:equatable/equatable.dart';

import '../contents/contents.dart';
import '../dtos/dtos.dart';

enum LocalRequestStatus { Draft, Open, DecisionRequired, ManualDecisionRequired, Decided, Completed, Expired }

class LocalRequestDTO extends Equatable {
  final String id;
  final bool isOwn;
  final String peer;
  final String createdAt;
  final LocalRequestStatus status;
  final Request content;
  final LocalRequestSourceDTO? source;
  final LocalResponseDTO? response;

  const LocalRequestDTO({
    required this.id,
    required this.isOwn,
    required this.peer,
    required this.createdAt,
    required this.status,
    required this.content,
    this.source,
    this.response,
  });

  factory LocalRequestDTO.fromJson(Map json) {
    return LocalRequestDTO(
      id: json['id'],
      isOwn: json['isOwn'],
      peer: json['peer'],
      createdAt: json['createdAt'],
      status: LocalRequestStatus.values.byName(json['status']),
      content: Request.fromJson(json['content']),
      source: LocalRequestSourceDTO.fromJsonNullable(json['source']),
      response: LocalResponseDTO.fromJsonNullable(json['response']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'isOwn': isOwn,
        'peer': peer,
        'createdAt': createdAt,
        'status': status.name,
        'content': content.toJson(),
        if (source != null) 'source': source?.toJson(),
        if (response != null) 'response': response?.toJson(),
      };

  @override
  List<Object?> get props => [id, isOwn, peer, createdAt, status, content, source, response];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../contents/contents.dart';
import '../dtos/dtos.dart';

part 'local_request.g.dart';

enum LocalRequestStatus { Draft, Open, DecisionRequired, ManualDecisionRequired, Decided, Completed, Expired }

@JsonSerializable(includeIfNull: false)
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

  factory LocalRequestDTO.fromJson(Map json) => _$LocalRequestDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$LocalRequestDTOToJson(this);

  @override
  List<Object?> get props => [id, isOwn, peer, createdAt, status, content, source, response];
}

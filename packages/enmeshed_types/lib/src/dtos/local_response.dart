import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../contents/contents.dart';
import 'local_response_source.dart';

part 'local_response.g.dart';

@JsonSerializable(includeIfNull: false)
class LocalResponseDTO extends Equatable {
  final String createdAt;
  final Response content;
  final LocalResponseSourceDTO? source;

  const LocalResponseDTO({required this.createdAt, required this.content, this.source});

  factory LocalResponseDTO.fromJson(Map json) => _$LocalResponseDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$LocalResponseDTOToJson(this);

  @override
  List<Object?> get props => [createdAt, content, source];
}

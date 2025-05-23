import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_response_source.g.dart';

enum LocalResponseSourceType { Message, Relationship }

@JsonSerializable(includeIfNull: false)
class LocalResponseSourceDTO extends Equatable {
  final LocalResponseSourceType type;
  final String reference;

  const LocalResponseSourceDTO({required this.type, required this.reference});

  factory LocalResponseSourceDTO.fromJson(Map json) => _$LocalResponseSourceDTOFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$LocalResponseSourceDTOToJson(this);

  @override
  List<Object?> get props => [type, reference];
}

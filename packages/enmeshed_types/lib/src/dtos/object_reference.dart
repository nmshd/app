import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'object_reference.g.dart';

@JsonSerializable(includeIfNull: false)
class ObjectReferenceDTO extends Equatable {
  final String truncated;
  final String url;

  const ObjectReferenceDTO({required this.truncated, required this.url});

  factory ObjectReferenceDTO.fromJson(Map json) => _$ObjectReferenceDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$ObjectReferenceDTOToJson(this);

  @override
  List<Object?> get props => [truncated, url];
}

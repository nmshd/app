import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attribute_tag_collection.g.dart';

@JsonSerializable(includeIfNull: false)
class AttributeTagCollectionDTO extends Equatable {
  final List<String> supportedLanguages;
  final Map<String, Map<String, AttributeTagDTO>> tagsForAttributeValueTypes;

  const AttributeTagCollectionDTO({required this.supportedLanguages, required this.tagsForAttributeValueTypes});

  factory AttributeTagCollectionDTO.fromJson(Map json) => _$AttributeTagCollectionDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$AttributeTagCollectionDTOToJson(this);

  @override
  List<Object?> get props => [supportedLanguages, tagsForAttributeValueTypes];
}

@JsonSerializable(includeIfNull: false)
class AttributeTagDTO extends Equatable {
  final Map<String, String> displayNames;
  final Map<String, AttributeTagDTO>? children;

  const AttributeTagDTO({required this.displayNames, this.children});

  factory AttributeTagDTO.fromJson(Map json) => _$AttributeTagDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$AttributeTagDTOToJson(this);

  @override
  List<Object?> get props => [displayNames, children];
}

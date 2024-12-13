// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_tag_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeTagCollectionDTO _$AttributeTagCollectionDTOFromJson(Map<String, dynamic> json) => AttributeTagCollectionDTO(
      supportedLanguages: (json['supportedLanguages'] as List<dynamic>).map((e) => e as String).toList(),
      tagsForAttributeValueTypes: (json['tagsForAttributeValueTypes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, AttributeTagDTO.fromJson(e as Map<String, dynamic>)),
            )),
      ),
    );

Map<String, dynamic> _$AttributeTagCollectionDTOToJson(AttributeTagCollectionDTO instance) => <String, dynamic>{
      'supportedLanguages': instance.supportedLanguages,
      'tagsForAttributeValueTypes': instance.tagsForAttributeValueTypes.map((k, e) => MapEntry(k, e.map((k, e) => MapEntry(k, e.toJson())))),
    };

AttributeTagDTO _$AttributeTagDTOFromJson(Map<String, dynamic> json) => AttributeTagDTO(
      displayNames: Map<String, String>.from(json['displayNames'] as Map),
      children: (json['children'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, AttributeTagDTO.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$AttributeTagDTOToJson(AttributeTagDTO instance) => <String, dynamic>{
      'displayNames': instance.displayNames,
      if (instance.children?.map((k, e) => MapEntry(k, e.toJson())) case final value?) 'children': value,
    };

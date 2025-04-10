// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_item_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseItemGroup _$ResponseItemGroupFromJson(Map<String, dynamic> json) =>
    ResponseItemGroup(items: (json['items'] as List<dynamic>).map((e) => ResponseItemDerivation.fromJson(e as Map<String, dynamic>)).toList());

Map<String, dynamic> _$ResponseItemGroupToJson(ResponseItemGroup instance) => <String, dynamic>{
  '@type': instance.atType,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

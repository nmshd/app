// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_file_ownership_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferFileOwnershipRequestItem _$TransferFileOwnershipRequestItemFromJson(Map<String, dynamic> json) => TransferFileOwnershipRequestItem(
  title: json['title'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  fileReference: json['fileReference'] as String,
  ownershipToken: json['ownershipToken'] as String?,
);

Map<String, dynamic> _$TransferFileOwnershipRequestItemToJson(TransferFileOwnershipRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'title': ?instance.title,
  'description': ?instance.description,
  'metadata': ?instance.metadata,
  'mustBeAccepted': instance.mustBeAccepted,
  'requireManualDecision': ?instance.requireManualDecision,
  'fileReference': instance.fileReference,
  'ownershipToken': ?instance.ownershipToken,
};

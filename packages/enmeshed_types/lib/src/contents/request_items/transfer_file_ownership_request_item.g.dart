// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_file_ownership_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferFileOwnershipRequestItem _$TransferFileOwnershipRequestItemFromJson(Map<String, dynamic> json) => TransferFileOwnershipRequestItem(
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  mustBeAccepted: json['mustBeAccepted'] as bool,
  requireManualDecision: json['requireManualDecision'] as bool?,
  fileReference: json['fileReference'] as String,
);

Map<String, dynamic> _$TransferFileOwnershipRequestItemToJson(TransferFileOwnershipRequestItem instance) => <String, dynamic>{
  '@type': instance.atType,
  if (instance.description case final value?) 'description': value,
  if (instance.metadata case final value?) 'metadata': value,
  'mustBeAccepted': instance.mustBeAccepted,
  if (instance.requireManualDecision case final value?) 'requireManualDecision': value,
  'fileReference': instance.fileReference,
};

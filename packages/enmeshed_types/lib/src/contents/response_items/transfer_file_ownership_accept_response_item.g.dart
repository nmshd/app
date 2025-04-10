// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_file_ownership_accept_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferFileOwnershipAcceptResponseItem _$TransferFileOwnershipAcceptResponseItemFromJson(Map<String, dynamic> json) =>
    TransferFileOwnershipAcceptResponseItem(
      attributeId: json['attributeId'] as String,
      attribute: AbstractAttribute.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransferFileOwnershipAcceptResponseItemToJson(TransferFileOwnershipAcceptResponseItem instance) => <String, dynamic>{
  '@type': instance.atType,
  'result': _$ResponseItemResultEnumMap[instance.result]!,
  'attributeId': instance.attributeId,
  'attribute': instance.attribute.toJson(),
};

const _$ResponseItemResultEnumMap = {
  ResponseItemResult.Accepted: 'Accepted',
  ResponseItemResult.Rejected: 'Rejected',
  ResponseItemResult.Error: 'Error',
};

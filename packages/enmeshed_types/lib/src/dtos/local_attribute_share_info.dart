import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_attribute_share_info.g.dart';

@JsonSerializable(includeIfNull: false)
class LocalAttributeShareInfo extends Equatable {
  final String? requestReference;
  final String? notificationReference;
  final String peer;
  final String? sourceAttribute;
  final String? thirdPartyAddress;

  const LocalAttributeShareInfo({
    this.requestReference,
    this.notificationReference,
    required this.peer,
    this.sourceAttribute,
    this.thirdPartyAddress,
  });

  factory LocalAttributeShareInfo.fromJson(Map json) => _$LocalAttributeShareInfoFromJson(Map<String, dynamic>.from(json));

  static LocalAttributeShareInfo? fromJsonNullable(Map? json) => json != null ? LocalAttributeShareInfo.fromJson(json) : null;

  Map<String, dynamic> toJson() => _$LocalAttributeShareInfoToJson(this);

  @override
  List<Object?> get props => [requestReference, notificationReference, peer, sourceAttribute, thirdPartyAddress];
}

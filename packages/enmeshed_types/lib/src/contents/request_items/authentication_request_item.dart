import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'authentication_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class AuthenticationRequestItem extends RequestItemDerivation {
  const AuthenticationRequestItem({super.title, super.description, super.metadata, required super.mustBeAccepted, super.requireManualDecision})
    : super(atType: 'AuthenticationRequestItem');

  factory AuthenticationRequestItem.fromJson(Map json) => _$AuthenticationRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$AuthenticationRequestItemToJson(this);

  @override
  List<Object?> get props => [...super.props];
}

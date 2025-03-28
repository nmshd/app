import 'package:json_annotation/json_annotation.dart';

import 'request_item_derivation.dart';

part 'authentication_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class AuthenticationRequestItem extends RequestItemDerivation {
  const AuthenticationRequestItem({super.title, super.description, super.metadata, required super.mustBeAccepted, super.requireManualDecision});

  factory AuthenticationRequestItem.fromJson(Map json) => _$AuthenticationRequestItemFromJson(Map<String, dynamic>.from(json));
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$AuthenticationRequestItemToJson(this));
    json['@type'] = 'AuthenticationRequestItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props];
}

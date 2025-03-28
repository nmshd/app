import 'package:json_annotation/json_annotation.dart';

import '../attribute_query/attribute_query.dart';
import 'request_item_derivation.dart';

part 'register_attribute_listener_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class RegisterAttributeListenerRequestItem extends RequestItemDerivation {
  final AttributeQuery query;

  const RegisterAttributeListenerRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
  });

  factory RegisterAttributeListenerRequestItem.fromJson(Map json) => _$RegisterAttributeListenerRequestItemFromJson(Map<String, dynamic>.from(json));
  
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll(_$RegisterAttributeListenerRequestItemToJson(this));
    json['@type'] = 'RegisterAttributeListenerRequestItem';
    return json;
  }

  @override
  List<Object?> get props => [super.props, query];
}

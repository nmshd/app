import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import 'request_item_derivation.dart';

part 'create_attribute_request_item.g.dart';

@JsonSerializable(includeIfNull: false)
class CreateAttributeRequestItem extends RequestItemDerivation {
  final AbstractAttribute attribute;

  const CreateAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attribute,
  });

  factory CreateAttributeRequestItem.fromJson(Map json) => _$CreateAttributeRequestItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => {..._$CreateAttributeRequestItemToJson(this), '@type': 'CreateAttributeRequestItem'};

  @override
  List<Object?> get props => [super.props, attribute];
}

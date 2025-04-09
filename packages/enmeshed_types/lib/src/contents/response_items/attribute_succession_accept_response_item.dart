import 'package:json_annotation/json_annotation.dart';

import '../abstract_attribute.dart';
import 'accept_response_item.dart';

part 'attribute_succession_accept_response_item.g.dart';

@JsonSerializable(includeIfNull: false)
class AttributeSuccessionAcceptResponseItem extends AcceptResponseItem {
  final String predecessorId;
  final String successorId;
  final AbstractAttribute successorContent;

  const AttributeSuccessionAcceptResponseItem({required this.predecessorId, required this.successorId, required this.successorContent})
    : super(atType: 'AttributeSuccessionAcceptResponseItem');

  factory AttributeSuccessionAcceptResponseItem.fromJson(Map json) =>
      _$AttributeSuccessionAcceptResponseItemFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$AttributeSuccessionAcceptResponseItemToJson(this);

  @override
  List<Object?> get props => [super.props, predecessorId, successorId, successorContent];
}

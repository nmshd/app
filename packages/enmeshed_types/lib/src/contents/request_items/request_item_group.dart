import 'package:json_annotation/json_annotation.dart';

import 'request_item.dart';
import 'request_item_derivation.dart';

part 'request_item_group.g.dart';

@JsonSerializable(includeIfNull: false)
class RequestItemGroup extends RequestItem {
  final List<RequestItemDerivation> items;

  const RequestItemGroup({super.title, super.description, super.metadata, required this.items}) : super(atType: 'RequestItemGroup');

  factory RequestItemGroup.fromJson(Map json) => _$RequestItemGroupFromJson(Map<String, dynamic>.from(json));

  @override
  Map<String, dynamic> toJson() => _$RequestItemGroupToJson(this);

  @override
  List<Object?> get props => [super.props, items];
}

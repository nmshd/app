import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'request_items/request_item.dart';

part 'request.g.dart';

@JsonSerializable(includeIfNull: false)
class Request extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType = 'Request';

  final String? id;
  final String? expiresAt;
  final List<RequestItem> items;
  final String? title;
  final String? description;
  final Map<String, dynamic>? metadata;

  const Request({this.id, this.expiresAt, required this.items, this.title, this.description, this.metadata});

  factory Request.fromJson(Map json) => _$RequestFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  @override
  List<Object?> get props => [id, expiresAt, items, title, description, metadata];
}

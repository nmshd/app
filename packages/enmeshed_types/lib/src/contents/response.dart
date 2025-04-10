import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'response_items/response_item.dart';

part 'response.g.dart';

enum ResponseResult { Accepted, Rejected }

@JsonSerializable(includeIfNull: false)
class Response extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType = 'Response';

  final ResponseResult result;
  final String requestId;
  final List<ResponseItem> items;

  const Response({required this.result, required this.requestId, required this.items});

  factory Response.fromJson(Map json) => _$ResponseFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$ResponseToJson(this);

  @override
  List<Object?> get props => [result, requestId, items];
}

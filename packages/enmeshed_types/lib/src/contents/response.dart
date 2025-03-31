import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'response_items/response_item.dart';

part 'response.g.dart';

enum ResponseResult { Accepted, Rejected }

@JsonSerializable(includeIfNull: false)
class Response extends Equatable {
  final ResponseResult result;
  final String requestId;
  final List<ResponseItem> items;

  const Response({required this.result, required this.requestId, required this.items});

  factory Response.fromJson(Map json) => _$ResponseFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() {
    final json = _$ResponseToJson(this);
    json['@type'] = 'Response';
    return json;
  }

  @override
  List<Object?> get props => [result, requestId, items];
}

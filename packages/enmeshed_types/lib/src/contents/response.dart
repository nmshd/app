import 'package:equatable/equatable.dart';

import 'response_items/response_item.dart';

enum ResponseResult { Accepted, Rejected }

class Response extends Equatable {
  final ResponseResult result;
  final String requestId;
  final List<ResponseItem> items;

  const Response({required this.result, required this.requestId, required this.items});

  factory Response.fromJson(Map json) {
    return Response(
      result: ResponseResult.values.byName(json['result']),
      requestId: json['requestId'],
      items: List<ResponseItem>.from(json['items'].map((x) => ResponseItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    '@type': 'Response',
    'result': result.name,
    'requestId': requestId,
    'items': items.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [result, requestId, items];
}

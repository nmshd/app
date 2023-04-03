import 'package:equatable/equatable.dart';

import 'response_item/response_item.dart';

class Response extends Equatable {
  final String result;
  final String requestId;
  final List<ResponseItem> items;

  const Response({
    required this.result,
    required this.requestId,
    required this.items,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      result: json['result'],
      requestId: json['requestId'],
      items: List<ResponseItem>.from(json['items'].map((x) => ResponseItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'result': result,
        'requestId': requestId,
        'items': items.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => 'ResponseJSON(result: $result, requestId: $requestId, items: $items)';

  @override
  List<Object?> get props => [result, requestId, items];
}

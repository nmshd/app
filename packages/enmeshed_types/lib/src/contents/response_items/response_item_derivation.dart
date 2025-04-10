import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'accept_response_item.dart';
import 'error_response_item.dart';
import 'reject_response_item.dart';
import 'response_item.dart';

abstract class ResponseItemDerivation extends ResponseItem {
  @JsonKey(name: 'result', includeToJson: true)
  final ResponseItemResult result;

  const ResponseItemDerivation({required this.result, required super.atType});

  factory ResponseItemDerivation.fromJson(Map json) {
    final type = json['@type'];

    if (type == null || type.runtimeType != String) throw Exception('missing @type on ResponseItemDerivation');

    if (type == 'RejectResponseItem') return RejectResponseItem.fromJson(json);
    if (type == 'ErrorResponseItem') return ErrorResponseItem.fromJson(json);

    if ((type as String).contains('AcceptResponseItem')) return AcceptResponseItem.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  @mustCallSuper
  @override
  List<Object?> get props => [result];
}

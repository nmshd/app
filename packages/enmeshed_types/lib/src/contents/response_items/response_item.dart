import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'response_item_derivation.dart';
import 'response_item_group.dart';

export 'response_item_result.dart';

abstract class ResponseItem extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType;

  const ResponseItem({required this.atType});

  factory ResponseItem.fromJson(Map json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on ResponseItem');

    if (type == 'ResponseItemGroup') return ResponseItemGroup.fromJson(json);
    if (type.endsWith('ResponseItem')) return ResponseItemDerivation.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  Map<String, dynamic> toJson();

  @override
  @mustCallSuper
  List<Object?> get props;
}

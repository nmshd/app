import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../contents.dart';

part 'response_item_group.dart';

enum ResponseItemResult { Accepted, Rejected, Error }

abstract class ResponseItem extends Equatable {
  const ResponseItem();

  factory ResponseItem.fromJson(Map json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on ResponseItem');

    if (type == 'ResponseItemGroup') return ResponseItemGroup.fromJson(json);
    if (type.endsWith('ResponseItem')) return ResponseItemDerivation.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  @mustCallSuper
  Map<String, dynamic> toJson();

  @override
  @mustCallSuper
  List<Object?> get props;
}

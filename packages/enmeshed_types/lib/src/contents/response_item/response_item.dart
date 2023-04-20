import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../contents.dart';

part 'accept_response_item.dart';
part 'create_attribute_accept_response_item.dart';
part 'error_response_item.dart';
part 'propose_attribute_accept_response_item.dart';
part 'read_attribute_accept_response_item.dart';
part 'register_attribute_listener_accept_response_item.dart';
part 'reject_response_item.dart';
part 'response_item_derivation.dart';
part 'response_item_group.dart';
part 'share_attribute_accept_response_item.dart';
part 'succeed_attribute_accept_response_item.dart';

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

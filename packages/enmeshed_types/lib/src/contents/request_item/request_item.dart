import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../contents/contents.dart';

part 'authentication_request_item.dart';
part 'consent_request_item.dart';
part 'create_attribute_request_item.dart';
part 'propose_attribute_request_item.dart';
part 'read_attribute_request_item.dart';
part 'register_attribute_listener_request_item.dart';
part 'request_item_derivation.dart';
part 'request_item_group.dart';
part 'share_attribute_request_item.dart';
part 'succeed_attribute_request_item.dart';

abstract class RequestItem extends Equatable {
  final String? title;
  final String? description;
  final Map<String, dynamic>? metadata;
  final bool mustBeAccepted;

  const RequestItem({
    this.title,
    this.description,
    this.metadata,
    required this.mustBeAccepted,
  });

  factory RequestItem.fromJson(Map<String, dynamic> json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on RequestItem');

    if (type == 'RequestItemGroup') return RequestItemGroup.fromJson(json);
    if (type.endsWith('RequestItem')) return RequestItemDerivation.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  @mustCallSuper
  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (metadata != null) 'metadata': metadata,
        'mustBeAccepted': mustBeAccepted,
      };

  @override
  String toString() {
    return 'RequestItem(title: $title, description: $description, metadata: $metadata, mustBeAccepted: $mustBeAccepted)';
  }

  @mustCallSuper
  @override
  List<Object?> get props => [title, description, metadata, mustBeAccepted];
}

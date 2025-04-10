import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'request_item_derivation.dart';
import 'request_item_group.dart';

abstract class RequestItem extends Equatable {
  @JsonKey(name: '@type', includeToJson: true)
  final String atType;

  final String? title;
  final String? description;
  final Map<String, dynamic>? metadata;

  const RequestItem({this.title, this.description, this.metadata, required this.atType});

  factory RequestItem.fromJson(Map json) {
    final type = json['@type'];
    if (type == null) throw Exception('missing @type on RequestItem');

    if (type == 'RequestItemGroup') return RequestItemGroup.fromJson(json);
    if (type.endsWith('RequestItem')) return RequestItemDerivation.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props => [title, description, metadata];
}

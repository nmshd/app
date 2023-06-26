import 'package:json_annotation/json_annotation.dart';

import 'common/common.dart';

class DataViewObject {
  @JsonKey(includeToJson: true)
  final String id;
  @JsonKey(includeToJson: true)
  final String name;
  @JsonKey(includeToJson: true)
  final String? description;
  @JsonKey(includeToJson: true)
  final String? image;
  @JsonKey(includeToJson: true)
  final String type;
  @JsonKey(includeToJson: true)
  final String? date;
  @JsonKey(includeToJson: true)
  final DVOError? error;
  @JsonKey(includeToJson: true)
  final DVOWarning? warning;

  DataViewObject({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.type,
    this.date,
    this.error,
    this.warning,
  });
}

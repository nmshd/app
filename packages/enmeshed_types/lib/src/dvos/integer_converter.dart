import 'package:json_annotation/json_annotation.dart';

class IntegerConverter implements JsonConverter<int, dynamic> {
  const IntegerConverter();

  @override
  int fromJson(dynamic json) => json.toInt();

  @override
  dynamic toJson(int object) => object;
}

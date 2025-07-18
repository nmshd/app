import 'package:json_annotation/json_annotation.dart';

class IntegerConverter implements JsonConverter<int, int> {
  const IntegerConverter();

  @override
  int fromJson(dynamic json) => switch (json) {
    String() => int.parse(json),
    num() => json.toInt(),
    _ => throw Exception('Invalid type for IntegerConverter: ${json.runtimeType}'),
  };

  @override
  int toJson(int object) => object;
}

class OptionalIntegerConverter implements JsonConverter<int?, int?> {
  const OptionalIntegerConverter();

  @override
  int? fromJson(dynamic json) => switch (json) {
    null => null,
    String() => int.parse(json),
    num() => json.toInt(),
    _ => throw Exception('Invalid type for IntegerConverter: ${json.runtimeType}'),
  };

  @override
  int? toJson(int? object) => object;
}

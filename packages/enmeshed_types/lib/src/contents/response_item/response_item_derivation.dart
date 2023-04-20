part of 'response_item.dart';

abstract class ResponseItemDerivation extends ResponseItem {
  final ResponseItemResult result;

  const ResponseItemDerivation({required this.result});

  factory ResponseItemDerivation.fromJson(Map json) {
    final type = json['@type'];

    if (type == null || type.runtimeType != String) throw Exception('missing @type on ResponseItemDerivation');

    if (type == 'RejectResponseItem') return RejectResponseItem.fromJson(json);
    if (type == 'ErrorResponseItem') return ErrorResponseItem.fromJson(json);

    if ((type as String).contains('AcceptResponseItem')) return AcceptResponseItem.fromJson(json);

    throw Exception('Unknown type: $type');
  }

  @override
  Map<String, dynamic> toJson() => {
        'result': result.name,
      };

  @override
  List<Object?> get props => [result];
}

part of 'response_item.dart';

class ResponseItemGroup extends ResponseItem {
  final List<ResponseItemDerivation> items;

  const ResponseItemGroup({
    required super.result,
    required this.items,
  });

  factory ResponseItemGroup.fromJson(Map<String, dynamic> json) {
    return ResponseItemGroup(
      result: ResponseItemResult.values.byName(json['result']),
      items: List<ResponseItemDerivation>.from(json['items'].map((x) => ResponseItemDerivation.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'ResponseItemGroup',
        'items': items.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => 'ResponseItemGroup(items: $items)';

  @override
  List<Object?> get props => [super.props, items];
}

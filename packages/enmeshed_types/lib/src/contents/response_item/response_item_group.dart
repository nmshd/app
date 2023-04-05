part of 'response_item.dart';

class ResponseItemGroup extends ResponseItem {
  final List<ResponseItemDerivation> items;

  ResponseItemGroup({
    required this.items,
  });

  factory ResponseItemGroup.fromJson(Map<String, dynamic> json) {
    return ResponseItemGroup(
      items: List<ResponseItemDerivation>.from(json['items'].map((x) => ResponseItemDerivation.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'ResponseItemGroup',
        'items': items.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => 'ResponseItemGroup(items: $items)';
}

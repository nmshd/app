part of 'request_item.dart';

class RequestItemGroup extends RequestItem {
  final List<RequestItemDerivation> items;

  RequestItemGroup({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    required this.items,
  });

  factory RequestItemGroup.fromJson(Map<String, dynamic> json) {
    return RequestItemGroup(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'],
      mustBeAccepted: json['mustBeAccepted'],
      items: List<RequestItemDerivation>.from(json['items'].map((x) => RequestItemDerivation.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'RequestItemGroup',
        'items': items.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => 'RequestItemGroup(items: $items)';
}

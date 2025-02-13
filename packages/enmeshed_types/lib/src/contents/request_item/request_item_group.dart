part of 'request_item.dart';

class RequestItemGroup extends RequestItem {
  final List<RequestItemDerivation> items;

  const RequestItemGroup({super.title, super.description, super.metadata, required this.items});

  factory RequestItemGroup.fromJson(Map json) {
    return RequestItemGroup(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      items: List<RequestItemDerivation>.from(json['items'].map((x) => RequestItemDerivation.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'RequestItemGroup', 'items': items.map((e) => e.toJson()).toList()};

  @override
  List<Object?> get props => [super.props, items];
}

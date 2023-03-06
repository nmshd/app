import 'request_item/request_item.dart';

class Request {
  final String? id;
  final String? expiresAt;
  final List<RequestItem> items;
  final String? title;
  final String? description;
  final Map<String, dynamic>? metadata;

  Request({
    this.id,
    this.expiresAt,
    required this.items,
    this.title,
    this.description,
    this.metadata,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      expiresAt: json['expiresAt'],
      items: List<RequestItem>.from(json['items'].map((x) => RequestItem.fromJson(x))),
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (expiresAt != null) 'expiresAt': expiresAt,
      'items': items.map((e) => e.toJson()).toList(),
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  String toString() {
    return 'Request(id: $id, expiresAt: $expiresAt, items: $items, title: $title, description: $description, metadata: $metadata)';
  }
}

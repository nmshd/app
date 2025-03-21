import 'package:equatable/equatable.dart';

import 'request_items/request_item.dart';

class Request extends Equatable {
  final String? id;
  final String? expiresAt;
  final List<RequestItem> items;
  final String? title;
  final String? description;
  final Map<String, dynamic>? metadata;

  const Request({this.id, this.expiresAt, required this.items, this.title, this.description, this.metadata});

  factory Request.fromJson(Map json) {
    return Request(
      id: json['id'],
      expiresAt: json['expiresAt'],
      items: List<RequestItem>.from(json['items'].map((x) => RequestItem.fromJson(x))),
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': 'Request',
      if (id != null) 'id': id,
      if (expiresAt != null) 'expiresAt': expiresAt,
      'items': items.map((e) => e.toJson()).toList(),
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  List<Object?> get props => [id, expiresAt, items, title, description, metadata];
}

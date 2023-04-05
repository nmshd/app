part of 'request_item.dart';

class RegisterAttributeListenerRequestItem extends RequestItemDerivation {
  final AttributeQuery query;

  const RegisterAttributeListenerRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
  });

  factory RegisterAttributeListenerRequestItem.fromJson(Map<String, dynamic> json) {
    return RegisterAttributeListenerRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'],
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      query: AttributeQuery.fromJson(json['query']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'RegisterAttributeListenerRequestItem',
        'query': query.toJson(),
      };

  @override
  String toString() => 'RegisterAttributeListenerRequestItem(query: $query)';

  @override
  List<Object?> get props => [super.props, query];
}

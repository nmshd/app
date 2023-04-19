part of 'request_item.dart';

class ReadAttributeRequestItem extends RequestItemDerivation {
  final AttributeQuery query;

  const ReadAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.query,
  });

  factory ReadAttributeRequestItem.fromJson(Map<String, dynamic> json) {
    return ReadAttributeRequestItem(
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
        '@type': 'ReadAttributeRequestItem',
        'query': query.toJson(),
      };

  @override
  String toString() => 'ReadAttributeRequestItem(query: $query)';

  @override
  List<Object?> get props => [super.props, query];
}

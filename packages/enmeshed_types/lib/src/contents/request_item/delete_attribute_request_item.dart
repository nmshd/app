part of 'request_item.dart';

class DeleteAttributeRequestItem extends RequestItemDerivation {
  final String attributeId;

  const DeleteAttributeRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.attributeId,
  });

  factory DeleteAttributeRequestItem.fromJson(Map json) {
    return DeleteAttributeRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      attributeId: json['attributeId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '@type': 'DeleteAttributeRequestItem',
        'attributeId': attributeId,
      };

  @override
  String toString() => 'DeleteAttributeRequestItem(attributeId: $attributeId)';

  @override
  List<Object?> get props => [super.props, attributeId];
}

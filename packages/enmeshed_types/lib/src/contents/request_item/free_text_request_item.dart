part of 'request_item.dart';

class FreeTextRequestItem extends RequestItemDerivation {
  final String freeText;

  const FreeTextRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.freeText,
  });

  factory FreeTextRequestItem.fromJson(Map json) {
    return FreeTextRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      freeText: json['freeText'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'FreeTextRequestItem', 'freeText': freeText};

  @override
  List<Object?> get props => [super.props];
}

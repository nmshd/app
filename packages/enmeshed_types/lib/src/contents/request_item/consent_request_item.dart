part of 'request_item.dart';

class ConsentRequestItem extends RequestItemDerivation {
  final String consent;
  final String? link;
  final String? linkDisplayText;

  const ConsentRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.consent,
    this.link,
    this.linkDisplayText,
  });

  factory ConsentRequestItem.fromJson(Map json) {
    return ConsentRequestItem(
      title: json['title'],
      description: json['description'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      mustBeAccepted: json['mustBeAccepted'],
      requireManualDecision: json['requireManualDecision'],
      consent: json['consent'],
      link: json['link'],
      linkDisplayText: json['linkDisplayText'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    '@type': 'ConsentRequestItem',
    'consent': consent,
    if (link != null) 'link': link,
    if (linkDisplayText != null) 'linkDisplayText': linkDisplayText,
  };

  @override
  List<Object?> get props => [super.props, consent, link];
}

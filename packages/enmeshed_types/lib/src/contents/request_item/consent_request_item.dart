part of 'request_item.dart';

class ConsentRequestItem extends RequestItemDerivation {
  final String consent;
  final String? link;

  const ConsentRequestItem({
    super.title,
    super.description,
    super.metadata,
    required super.mustBeAccepted,
    super.requireManualDecision,
    required this.consent,
    this.link,
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
    );
  }

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), '@type': 'ConsentRequestItem', 'consent': consent, if (link != null) 'link': link};

  @override
  List<Object?> get props => [super.props, consent, link];
}

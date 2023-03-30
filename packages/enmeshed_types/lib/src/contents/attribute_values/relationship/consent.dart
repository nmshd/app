import '../../value_hints.dart';
import 'relationship_attribute_value.dart';

class Consent extends RelationshipAttributeValue {
  final String consent;
  final ValueHints? valueHintsOverride;
  final String? link;

  const Consent({
    required this.consent,
    this.valueHintsOverride,
    this.link,
  });

  factory Consent.fromJson(Map<String, dynamic> json) => Consent(
        consent: json['consent'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        link: json['link'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'Consent',
        'consent': consent,
        if (valueHintsOverride != null) 'valueHintsOverride': valueHintsOverride?.toJson(),
        if (link != null) 'link': link,
      };

  @override
  String toString() => 'Consent(consent: $consent, valueHintsOverride: $valueHintsOverride, link: $link)';

  @override
  List<Object?> get props => [consent, valueHintsOverride, link];
}

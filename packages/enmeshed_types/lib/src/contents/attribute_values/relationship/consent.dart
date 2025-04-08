import '../../value_hints.dart';
import 'relationship_attribute_value.dart';

class ConsentAttributeValue extends RelationshipAttributeValue {
  final String consent;
  final ValueHints? valueHintsOverride;
  final String? link;
  final String? linkDisplayText;

  const ConsentAttributeValue({required this.consent, this.valueHintsOverride, this.link, this.linkDisplayText}) : super('Consent');

  factory ConsentAttributeValue.fromJson(Map json) => ConsentAttributeValue(
    consent: json['consent'],
    valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
    link: json['link'],
    linkDisplayText: json['linkDisplayText'],
  );

  @override
  Map<String, dynamic> toJson() => {
    '@type': super.atType,
    'consent': consent,
    if (valueHintsOverride != null) 'valueHintsOverride': valueHintsOverride?.toJson(),
    if (link != null) 'link': link,
    if (linkDisplayText != null) 'linkDisplayText': linkDisplayText,
  };

  @override
  List<Object?> get props => [consent, valueHintsOverride, link];
}

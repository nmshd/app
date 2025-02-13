import '../../value_hints.dart';
import 'relationship_attribute_value.dart';

class ConsentAttributeValue extends RelationshipAttributeValue {
  final String consent;
  final ValueHints? valueHintsOverride;
  final String? link;

  const ConsentAttributeValue({required this.consent, this.valueHintsOverride, this.link}) : super('Consent');

  factory ConsentAttributeValue.fromJson(Map json) => ConsentAttributeValue(
    consent: json['consent'],
    valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
    link: json['link'],
  );

  @override
  Map<String, dynamic> toJson() => {
    '@type': super.atType,
    'consent': consent,
    if (valueHintsOverride != null) 'valueHintsOverride': valueHintsOverride?.toJson(),
    if (link != null) 'link': link,
  };

  @override
  List<Object?> get props => [consent, valueHintsOverride, link];
}

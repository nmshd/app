import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryLanguageAttributeValue extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryLanguageAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  }) : super('ProprietaryLanguage');

  factory ProprietaryLanguageAttributeValue.fromJson(Map json) => ProprietaryLanguageAttributeValue(
        title: json['title'],
        description: json['description'],
        valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
        value: json['value'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'value': value,
      };

  @override
  String toString() => 'ProprietaryLanguageAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}

import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryEMailAddressAttributeValue extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryEMailAddressAttributeValue({
    required super.title,
    super.description,
    super.valueHintsOverride,
    required this.value,
  }) : super('ProprietaryEMailAddress');

  factory ProprietaryEMailAddressAttributeValue.fromJson(Map json) => ProprietaryEMailAddressAttributeValue(
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
  String toString() => 'ProprietaryEMailAddressAttributeValue(value: $value)';

  @override
  List<Object?> get props => [super.props, value];
}

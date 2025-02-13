import '../../value_hints.dart';
import 'proprietary_attribute_value.dart';

class ProprietaryFileReferenceAttributeValue extends ProprietaryAttributeValue {
  final String value;

  const ProprietaryFileReferenceAttributeValue({required super.title, super.description, super.valueHintsOverride, required this.value})
    : super('ProprietaryFileReference');

  factory ProprietaryFileReferenceAttributeValue.fromJson(Map json) => ProprietaryFileReferenceAttributeValue(
    title: json['title'],
    description: json['description'],
    valueHintsOverride: json['valueHintsOverride'] != null ? ValueHints.fromJson(json['valueHintsOverride']) : null,
    value: json['value'],
  );

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};

  @override
  List<Object?> get props => [super.props, value];
}

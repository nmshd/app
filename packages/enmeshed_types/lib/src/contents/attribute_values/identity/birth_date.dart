import 'identity_attribute_value.dart';

class BirthDateAttributeValue extends IdentityAttributeValue {
  final int day;
  final int month;
  final int year;

  const BirthDateAttributeValue({
    required this.day,
    required this.month,
    required this.year,
  });

  factory BirthDateAttributeValue.fromJson(Map json) => BirthDateAttributeValue(
        day: json['day'].toInt(),
        month: json['month'].toInt(),
        year: json['year'].toInt(),
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthDate',
        'day': day,
        'month': month,
        'year': year,
      };

  @override
  String toString() => 'BirthDateAttributeValue(day: $day, month: $month, year: $year)';

  @override
  List<Object?> get props => [day, month, year];
}

import 'identity_attribute_value.dart';

class BirthDate extends IdentityAttributeValue {
  final int day;
  final int month;
  final int year;

  const BirthDate({
    required this.day,
    required this.month,
    required this.year,
  });

  factory BirthDate.fromJson(Map json) => BirthDate(
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
  String toString() => 'BirthDate(day: $day, month: $month, year: $year)';

  @override
  List<Object?> get props => [day, month, year];
}

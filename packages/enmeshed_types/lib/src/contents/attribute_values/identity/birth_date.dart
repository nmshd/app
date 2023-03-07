import 'identity_attriube_value.dart';

class BirthDate extends IdentityAttributeValue {
  final int day;
  final int month;
  final int year;

  BirthDate({
    required this.day,
    required this.month,
    required this.year,
  });

  factory BirthDate.fromJson(Map<String, dynamic> json) => BirthDate(
        day: json['day'],
        month: json['month'],
        year: json['year'],
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
}

import 'identity_attriube_value.dart';

class BirthPlace extends IdentityAttributeValue {
  final String city;
  final String country;
  final String? state;
  BirthPlace({
    required this.city,
    required this.country,
    this.state,
  });

  factory BirthPlace.fromJson(Map<String, dynamic> json) => BirthPlace(
        city: json['city'],
        country: json['country'],
        state: json['state'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'BirthPlace',
        'city': city,
        'country': country,
        if (state != null) 'state': state,
      };

  @override
  String toString() => 'BirthPlace(city: $city, country: $country, state: $state)';
}

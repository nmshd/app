import 'identity_attribute_value.dart';

class BirthPlaceAttributeValue extends IdentityAttributeValue {
  final String city;
  final String country;
  final String? state;

  const BirthPlaceAttributeValue({
    required this.city,
    required this.country,
    this.state,
  }) : super('BirthPlace');

  factory BirthPlaceAttributeValue.fromJson(Map json) => BirthPlaceAttributeValue(
        city: json['city'],
        country: json['country'],
        state: json['state'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': super.atType,
        'city': city,
        'country': country,
        if (state != null) 'state': state,
      };

  @override
  List<Object?> get props => [city, country, state];
}

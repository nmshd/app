import 'identity_attribute_value.dart';

class PersonNameAttributeValue extends IdentityAttributeValue {
  final String givenName;
  final String? middleName;
  final String surname;
  final String? honorificSuffix;
  final String? honorificPrefix;

  const PersonNameAttributeValue({
    required this.givenName,
    this.middleName,
    required this.surname,
    this.honorificSuffix,
    this.honorificPrefix,
  });

  factory PersonNameAttributeValue.fromJson(Map json) => PersonNameAttributeValue(
        givenName: json['givenName'],
        middleName: json['middleName'],
        surname: json['surname'],
        honorificSuffix: json['honorificSuffix'],
        honorificPrefix: json['honorificPrefix'],
      );

  @override
  Map<String, dynamic> toJson() => {
        '@type': 'PersonName',
        'givenName': givenName,
        if (middleName != null) 'middleName': middleName,
        'surname': surname,
        if (honorificSuffix != null) 'honorificSuffix': honorificSuffix,
        if (honorificPrefix != null) 'honorificPrefix': honorificPrefix,
      };

  @override
  String toString() {
    return 'PersonNameAttributeValue(givenName: $givenName, middleName: $middleName, surname: $surname, honorificSuffix: $honorificSuffix, honorificPrefix: $honorificPrefix)';
  }

  @override
  List<Object?> get props => [givenName, middleName, surname, honorificSuffix, honorificPrefix];
}

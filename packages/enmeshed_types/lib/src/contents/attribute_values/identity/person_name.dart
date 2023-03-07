import 'identity_attriube_value.dart';

class PersonName extends IdentityAttributeValue {
  final String givenName;
  final String? middleName;
  final String surname;
  final String? honorificSuffix;
  final String? honorificPrefix;
  PersonName({
    required this.givenName,
    this.middleName,
    required this.surname,
    this.honorificSuffix,
    this.honorificPrefix,
  });

  factory PersonName.fromJson(Map<String, dynamic> json) => PersonName(
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
    return 'PersonName(givenName: $givenName, middleName: $middleName, surname: $surname, honorificSuffix: $honorificSuffix, honorificPrefix: $honorificPrefix)';
  }
}

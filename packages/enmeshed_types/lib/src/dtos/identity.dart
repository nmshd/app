import 'package:equatable/equatable.dart';

class IdentityDTO extends Equatable {
  final String address;
  final String publicKey;
  final String realm;

  const IdentityDTO({
    required this.address,
    required this.publicKey,
    required this.realm,
  });

  factory IdentityDTO.fromJson(Map json) {
    return IdentityDTO(
      address: json['address'],
      publicKey: json['publicKey'],
      realm: json['realm'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'publicKey': publicKey,
      'realm': realm,
    };
  }

  @override
  List<Object?> get props => [address, publicKey, realm];
}

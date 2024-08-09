import 'package:equatable/equatable.dart';

class IdentityDTO extends Equatable {
  final String address;
  final String publicKey;

  const IdentityDTO({required this.address, required this.publicKey});

  factory IdentityDTO.fromJson(Map json) {
    return IdentityDTO(address: json['address'], publicKey: json['publicKey']);
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'publicKey': publicKey};
  }

  @override
  List<Object?> get props => [address, publicKey];
}

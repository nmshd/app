import 'package:equatable/equatable.dart';

class GetIdentityInfoResponse extends Equatable {
  final String address;
  final String publicKey;

  const GetIdentityInfoResponse({required this.address, required this.publicKey});

  factory GetIdentityInfoResponse.fromJson(Map json) {
    return GetIdentityInfoResponse(address: json['address'], publicKey: json['publicKey']);
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'publicKey': publicKey};
  }

  @override
  List<Object?> get props => [address, publicKey];
}

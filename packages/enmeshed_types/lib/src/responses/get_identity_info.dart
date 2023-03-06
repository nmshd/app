class GetIdentityInfoResponse {
  final String address;
  final String publicKey;

  GetIdentityInfoResponse({
    required this.address,
    required this.publicKey,
  });

  factory GetIdentityInfoResponse.fromJson(Map<String, dynamic> json) {
    return GetIdentityInfoResponse(
      address: json['address'],
      publicKey: json['publicKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qrCodeBytes': address,
      'publicKey': publicKey,
    };
  }

  @override
  String toString() => 'GetIdentityInfoResponse(address: $address, publicKey: $publicKey)';
}

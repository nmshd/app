import 'package:equatable/equatable.dart';

import 'identity.dart';

class DeviceOnboardingInfoDTO extends Equatable {
  final String id;
  final String createdAt;
  final String createdByDevice;
  final String? name;
  final String? description;
  final String secretBaseKey;
  final int deviceIndex;
  final String synchronizationKey;
  final String? identityPrivateKey;
  final IdentityDTO identity;
  final String password;
  final String username;

  const DeviceOnboardingInfoDTO({
    required this.id,
    required this.createdAt,
    required this.createdByDevice,
    this.name,
    this.description,
    required this.secretBaseKey,
    required this.deviceIndex,
    required this.synchronizationKey,
    this.identityPrivateKey,
    required this.identity,
    required this.password,
    required this.username,
  });

  @override
  String toString() {
    return 'DeviceOnboardingInfo { id: $id, createdAt: $createdAt, createdByDevice: $createdByDevice, name: $name, description: $description, secretBaseKey: $secretBaseKey, deviceIndex: $deviceIndex, synchronizationKey: $synchronizationKey, identityPrivateKey: $identityPrivateKey, identity: $identity, password: $password, username: $username }';
  }

  factory DeviceOnboardingInfoDTO.fromJson(Map<String, dynamic> json) {
    return DeviceOnboardingInfoDTO(
      id: json['id'],
      createdAt: json['createdAt'],
      createdByDevice: json['createdByDevice'],
      name: json['name'],
      description: json['description'],
      secretBaseKey: json['secretBaseKey'],
      deviceIndex: json['deviceIndex'],
      synchronizationKey: json['synchronizationKey'],
      identityPrivateKey: json['identityPrivateKey'],
      identity: IdentityDTO.fromJson(json['identity']),
      password: json['password'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'createdByDevice': createdByDevice,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      'secretBaseKey': secretBaseKey,
      'deviceIndex': deviceIndex,
      'synchronizationKey': synchronizationKey,
      if (identityPrivateKey != null) 'identityPrivateKey': identityPrivateKey,
      'identity': identity.toJson(),
      'password': password,
      'username': username,
    };
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        createdByDevice,
        name,
        description,
        secretBaseKey,
        deviceIndex,
        synchronizationKey,
        identityPrivateKey,
        identity,
        password,
        username,
      ];
}

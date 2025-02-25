import 'package:equatable/equatable.dart';

import 'identity.dart';

class DeviceSharedSecret extends Equatable {
  final String id;
  final String createdAt;
  final String createdByDevice;
  final String? name;
  final String? description;
  final String? profileName;
  final String secretBaseKey;
  final int deviceIndex;
  final String synchronizationKey;
  final String? identityPrivateKey;
  final IdentityDTO identity;
  final String password;
  final String username;
  final bool isBackupDevice;

  const DeviceSharedSecret({
    required this.id,
    required this.createdAt,
    required this.createdByDevice,
    this.name,
    this.description,
    this.profileName,
    required this.secretBaseKey,
    required this.deviceIndex,
    required this.synchronizationKey,
    this.identityPrivateKey,
    required this.identity,
    required this.password,
    required this.username,
    required this.isBackupDevice,
  });

  factory DeviceSharedSecret.fromJson(Map json) {
    return DeviceSharedSecret(
      id: json['id'],
      createdAt: json['createdAt'],
      createdByDevice: json['createdByDevice'],
      name: json['name'],
      description: json['description'],
      profileName: json['profileName'],
      secretBaseKey: json['secretBaseKey'],
      deviceIndex: json['deviceIndex'].toInt(),
      synchronizationKey: json['synchronizationKey'],
      identityPrivateKey: json['identityPrivateKey'],
      identity: IdentityDTO.fromJson(json['identity']),
      password: json['password'],
      username: json['username'],
      isBackupDevice: json['isBackupDevice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'createdByDevice': createdByDevice,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (profileName != null) 'profileName': profileName,
      'secretBaseKey': secretBaseKey,
      'deviceIndex': deviceIndex,
      'synchronizationKey': synchronizationKey,
      if (identityPrivateKey != null) 'identityPrivateKey': identityPrivateKey,
      'identity': identity.toJson(),
      'password': password,
      'username': username,
      'isBackupDevice': isBackupDevice,
    };
  }

  @override
  List<Object?> get props => [
    id,
    createdAt,
    createdByDevice,
    name,
    description,
    profileName,
    secretBaseKey,
    deviceIndex,
    synchronizationKey,
    identityPrivateKey,
    identity,
    password,
    username,
    isBackupDevice,
  ];
}

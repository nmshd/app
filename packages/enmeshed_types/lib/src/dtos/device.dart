import 'package:equatable/equatable.dart';

class DeviceDTO extends Equatable {
  final String id;
  final String? publicKey;
  final String? certificate;
  final String name;
  final String? description;
  final String createdAt;
  final String createdByDevice;
  final String? operatingSystem;
  final String? lastLoginAt;
  final String type;
  final String username;

  const DeviceDTO({
    required this.id,
    this.publicKey,
    this.certificate,
    required this.name,
    this.description,
    required this.createdAt,
    required this.createdByDevice,
    this.operatingSystem,
    this.lastLoginAt,
    required this.type,
    required this.username,
  });

  factory DeviceDTO.fromJson(Map<String, dynamic> json) => DeviceDTO(
        id: json['id'],
        publicKey: json['publicKey'],
        certificate: json['certificate'],
        name: json['name'],
        description: json['description'],
        createdAt: json['createdAt'],
        createdByDevice: json['createdByDevice'],
        operatingSystem: json['operatingSystem'],
        lastLoginAt: json['lastLoginAt'],
        type: json['type'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        if (publicKey != null) 'publicKey': publicKey,
        if (certificate != null) 'certificate': certificate,
        'name': name,
        if (description != null) 'description': description,
        'createdAt': createdAt,
        'createdByDevice': createdByDevice,
        if (operatingSystem != null) 'operatingSystem': operatingSystem,
        if (lastLoginAt != null) 'lastLoginAt': lastLoginAt,
        'type': type,
        'username': username,
      };

  @override
  String toString() {
    return 'DeviceDTO(id: $id, publicKey: $publicKey, certificate: $certificate, name: $name, description: $description, createdAt: $createdAt, createdByDevice: $createdByDevice, operatingSystem: $operatingSystem, lastLoginAt: $lastLoginAt, type: $type, username: $username)';
  }

  @override
  List<Object?> get props => [
        id,
        publicKey,
        certificate,
        name,
        description,
        createdAt,
        createdByDevice,
        operatingSystem,
        lastLoginAt,
        type,
        username,
      ];
}

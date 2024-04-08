import 'package:equatable/equatable.dart';

class DeviceDTO extends Equatable {
  final String id;
  final bool isAdmin;
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
  final bool isCurrentDevice;
  final bool? isOffboarded;

  bool get isOnboarded => publicKey != null;

  const DeviceDTO({
    required this.id,
    required this.isAdmin,
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
    required this.isCurrentDevice,
    this.isOffboarded,
  });

  factory DeviceDTO.fromJson(Map json) => DeviceDTO(
        id: json['id'],
        isAdmin: json['isAdmin'],
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
        isCurrentDevice: json['isCurrentDevice'],
        isOffboarded: json['isOffboarded'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isAdmin': isAdmin,
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
        'isCurrentDevice': isCurrentDevice,
        if (isOffboarded != null) 'isOffboarded': isOffboarded,
      };

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
        isCurrentDevice,
        isOffboarded,
      ];
}

import 'package:equatable/equatable.dart';

class LocalAccountDTO extends Equatable {
  final String id;
  final String? address;
  final String name;
  final String directory;
  final int order;
  final String? lastAccessedAt;
  final String? devicePushIdentifier;
  final String? deletionDate;

  const LocalAccountDTO({
    required this.id,
    this.address,
    required this.name,
    required this.directory,
    required this.order,
    this.lastAccessedAt,
    this.devicePushIdentifier,
    this.deletionDate,
  });

  factory LocalAccountDTO.fromJson(Map json) {
    return LocalAccountDTO(
      id: json['id'],
      address: json['address'],
      name: json['name'],
      directory: json['directory'],
      order: json['order'].toInt(),
      lastAccessedAt: json['lastAccessedAt'],
      devicePushIdentifier: json['devicePushIdentifier'],
      deletionDate: json['deletionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (address != null) 'address': address,
      'name': name,
      'directory': directory,
      'order': order,
      if (lastAccessedAt != null) 'lastAccessedAt': lastAccessedAt,
      if (devicePushIdentifier != null) 'devicePushIdentifier': devicePushIdentifier,
      if (deletionDate != null) 'deletionDate': deletionDate,
    };
  }

  @override
  List<Object?> get props => [id, address, name, directory, order, lastAccessedAt, devicePushIdentifier, deletionDate];
}

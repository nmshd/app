import 'package:equatable/equatable.dart';

class LocalAccountDTO extends Equatable {
  final String id;
  final String address;
  final String name;
  final String realm;
  final String directory;
  final int order;

  const LocalAccountDTO({
    required this.id,
    required this.address,
    required this.name,
    required this.realm,
    required this.directory,
    required this.order,
  });

  @override
  String toString() {
    return 'LocalAccount { id: $id, address: $address, name: $name, realm: $realm, directory: $directory, order: $order }';
  }

  factory LocalAccountDTO.fromJson(Map<String, dynamic> json) {
    return LocalAccountDTO(
      id: json['id'],
      address: json['address'],
      name: json['name'],
      realm: json['realm'],
      directory: json['directory'],
      order: json['order'],
    );
  }

  @override
  List<Object?> get props => [id, address, name, realm, directory, order];
}

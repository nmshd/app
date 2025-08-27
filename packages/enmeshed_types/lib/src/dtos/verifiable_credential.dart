import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifiable_credential.g.dart';

@JsonSerializable()
class VerifiableCredentialDTO extends Equatable {
  final String status;
  final String message;
  final String data;

  const VerifiableCredentialDTO({required this.status, required this.message, required this.data});

  factory VerifiableCredentialDTO.fromJson(Map<String, dynamic> json) => _$VerifiableCredentialDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifiableCredentialDTOToJson(this);

  @override
  List<Object?> get props => [status, message, data];
}

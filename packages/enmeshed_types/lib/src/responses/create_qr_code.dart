import 'package:equatable/equatable.dart';

class CreateQrCodeResponse extends Equatable {
  final String qrCodeBytes;

  const CreateQrCodeResponse({required this.qrCodeBytes});

  factory CreateQrCodeResponse.fromJson(Map<String, dynamic> json) => CreateQrCodeResponse(qrCodeBytes: json['qrCodeBytes']);
  Map<String, dynamic> toJson() => {'qrCodeBytes': qrCodeBytes};

  @override
  List<Object?> get props => [qrCodeBytes];
}

import 'package:equatable/equatable.dart';

class CreateQRCodeResponse extends Equatable {
  final String qrCodeBytes;

  const CreateQRCodeResponse({required this.qrCodeBytes});

  factory CreateQRCodeResponse.fromJson(Map json) => CreateQRCodeResponse(qrCodeBytes: json['qrCodeBytes']);
  Map<String, dynamic> toJson() => {'qrCodeBytes': qrCodeBytes};

  @override
  List<Object?> get props => [qrCodeBytes];
}

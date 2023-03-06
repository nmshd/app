class CreateQrCodeResponse {
  final String qrCodeBytes;

  CreateQrCodeResponse({required this.qrCodeBytes});

  factory CreateQrCodeResponse.fromJson(Map<String, dynamic> json) => CreateQrCodeResponse(qrCodeBytes: json['qrCodeBytes']);
  Map<String, dynamic> toJson() => {'qrCodeBytes': qrCodeBytes};
}

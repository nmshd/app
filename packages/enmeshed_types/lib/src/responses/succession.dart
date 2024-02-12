import 'package:json_annotation/json_annotation.dart';

import '../dtos/dtos.dart';

part 'succession.g.dart';

@JsonSerializable(includeIfNull: false)
class NotifyPeerAboutIdentityAttributeSuccessionResponse {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;
  final String notificationId;

  NotifyPeerAboutIdentityAttributeSuccessionResponse({
    required this.predecessor,
    required this.successor,
    required this.notificationId,
  });

  factory NotifyPeerAboutIdentityAttributeSuccessionResponse.fromJson(Map<String, dynamic> json) =>
      _$NotifyPeerAboutIdentityAttributeSuccessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyPeerAboutIdentityAttributeSuccessionResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SucceedIdentityAttributeResponse {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;

  SucceedIdentityAttributeResponse({
    required this.predecessor,
    required this.successor,
  });

  factory SucceedIdentityAttributeResponse.fromJson(Map<String, dynamic> json) => _$SucceedIdentityAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SucceedIdentityAttributeResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SucceedRelationshipAttributeAndNotifyPeerResponse {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;
  final String notificationId;

  SucceedRelationshipAttributeAndNotifyPeerResponse({
    required this.predecessor,
    required this.successor,
    required this.notificationId,
  });

  factory SucceedRelationshipAttributeAndNotifyPeerResponse.fromJson(Map<String, dynamic> json) =>
      _$SucceedRelationshipAttributeAndNotifyPeerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SucceedRelationshipAttributeAndNotifyPeerResponseToJson(this);
}

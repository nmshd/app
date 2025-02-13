import 'package:json_annotation/json_annotation.dart';

import '../dtos/dtos.dart';

part 'succession.g.dart';

@JsonSerializable(includeIfNull: false)
class NotifyPeerAboutRepositoryAttributeSuccessionResponse {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;
  final String notificationId;

  NotifyPeerAboutRepositoryAttributeSuccessionResponse({required this.predecessor, required this.successor, required this.notificationId});

  factory NotifyPeerAboutRepositoryAttributeSuccessionResponse.fromJson(Map<String, dynamic> json) =>
      _$NotifyPeerAboutRepositoryAttributeSuccessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyPeerAboutRepositoryAttributeSuccessionResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SucceedRepositoryAttributeResponse {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;

  SucceedRepositoryAttributeResponse({required this.predecessor, required this.successor});

  factory SucceedRepositoryAttributeResponse.fromJson(Map<String, dynamic> json) => _$SucceedRepositoryAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SucceedRepositoryAttributeResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SucceedRelationshipAttributeAndNotifyPeerResponse {
  final LocalAttributeDTO predecessor;
  final LocalAttributeDTO successor;
  final String notificationId;

  SucceedRelationshipAttributeAndNotifyPeerResponse({required this.predecessor, required this.successor, required this.notificationId});

  factory SucceedRelationshipAttributeAndNotifyPeerResponse.fromJson(Map<String, dynamic> json) =>
      _$SucceedRelationshipAttributeAndNotifyPeerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SucceedRelationshipAttributeAndNotifyPeerResponseToJson(this);
}

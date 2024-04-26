import 'package:equatable/equatable.dart';

import 'sync_info_entry.dart';

class SyncInfoResponse extends Equatable {
  final SyncInfoEntry? lastDatawalletSync;
  final SyncInfoEntry? lastSyncRun;

  const SyncInfoResponse({
    this.lastDatawalletSync,
    this.lastSyncRun,
  });

  factory SyncInfoResponse.fromJson(Map json) => SyncInfoResponse(
        lastDatawalletSync: SyncInfoEntry.fromJsonNullable(json['lastDatawalletSync']),
        lastSyncRun: SyncInfoEntry.fromJsonNullable(json['lastSyncRun']),
      );

  Map<String, dynamic> toJson() => {
        if (lastDatawalletSync != null) 'lastDatawalletSync': lastDatawalletSync?.toJson(),
        if (lastSyncRun != null) 'lastSyncRun': lastSyncRun?.toJson(),
      };

  @override
  List<Object?> get props => [lastDatawalletSync, lastSyncRun];
}

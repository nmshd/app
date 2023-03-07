class SyncInfoEntry {
  final String completedAt;

  SyncInfoEntry({required this.completedAt});
  factory SyncInfoEntry.fromJson(Map<String, dynamic> json) => SyncInfoEntry(completedAt: json['completedAt']);
  static SyncInfoEntry? fromJsonNullable(Map<String, dynamic>? json) => json != null ? SyncInfoEntry.fromJson(json) : null;
  Map<String, dynamic> toJson() => {'completedAt': completedAt};

  @override
  String toString() => 'SyncInfoEntry(completedAt: $completedAt)';
}

class SyncInfoResponse {
  final SyncInfoEntry? lastDatawalletSync;
  final SyncInfoEntry? lastSyncRun;

  SyncInfoResponse({
    this.lastDatawalletSync,
    this.lastSyncRun,
  });

  factory SyncInfoResponse.fromJson(Map<String, dynamic> json) => SyncInfoResponse(
        lastDatawalletSync: SyncInfoEntry.fromJsonNullable(json['lastDatawalletSync']),
        lastSyncRun: SyncInfoEntry.fromJsonNullable(json['lastSyncRun']),
      );

  Map<String, dynamic> toJson() => {
        if (lastDatawalletSync != null) 'lastDatawalletSync': lastDatawalletSync?.toJson(),
        if (lastSyncRun != null) 'lastSyncRun': lastSyncRun?.toJson(),
      };

  @override
  String toString() => 'SyncInfoResponse(lastDatawalletSync: $lastDatawalletSync, lastSyncRun: $lastSyncRun)';
}

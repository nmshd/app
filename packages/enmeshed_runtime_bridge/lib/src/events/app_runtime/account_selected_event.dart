import '../event.dart';

class AccountSelectedEvent extends Event {
  final String localAccountId;
  final String address;

  const AccountSelectedEvent({
    required super.eventTargetAddress,
    required this.localAccountId,
    required this.address,
  });
}

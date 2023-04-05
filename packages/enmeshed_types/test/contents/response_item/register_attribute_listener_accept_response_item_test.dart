import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RegisterAttributeListenerAcceptResponseItem toJson', () {
    test('is correctly converted', () {
      const responseItem = RegisterAttributeListenerAcceptResponseItem(listenerId: 'aListenerId');
      final responseItemJson = responseItem.toJson();
      expect(
        responseItemJson,
        equals({'@type': 'RegisterAttributeListenerAcceptResponseItem', 'result': 'Accepted', 'listenerId': 'aListenerId'}),
      );
    });
  });

  group('RegisterAttributeListenerAcceptResponseItem fromJson', () {
    test('is correctly converted', () {
      final json = {'listenerId': 'aListenerId'};
      expect(
        RegisterAttributeListenerAcceptResponseItem.fromJson(json),
        equals(const RegisterAttributeListenerAcceptResponseItem(listenerId: 'aListenerId')),
      );
    });
  });
}

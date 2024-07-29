import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('ArbitraryMessageContent toJson', () {
    test('is correctly converted', () {
      final messageContent = ArbitraryMessageContent(const {'key': 'value'});
      final messageContentJson = messageContent.toJson();
      expect(
        messageContentJson,
        equals({
          '@type': 'ArbitraryMessageContent',
          'value': {'key': 'value'}
        }),
      );
    });
  });

  group('ArbitraryMessageContent fromJson', () {
    test('is correctly converted', () {
      final json = {
        '@type': 'ArbitraryMessageContent',
        'value': {'key': 'value'}
      };
      expect(
        ArbitraryMessageContent.fromJson(json),
        equals(ArbitraryMessageContent(const {'key': 'value'})),
      );
    });
  });
}

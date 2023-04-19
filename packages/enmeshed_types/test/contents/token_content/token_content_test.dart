import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('TokenContent fromJson', () {
    test('parsed valid ArbitraryTokenContent', () {
      final json = {'akey': 'aValue'};
      final content = TokenContent.fromJson(json);
      expect(content, isA<ArbitraryTokenContent>());
    });
  });
}

import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:test/test.dart';

void main() {
  group('RelationshipChangeResponseContent fromJson', () {
    test('parsed valid ArbitraryRelationshipChangeResponseContent', () {
      final json = {'akey': 'aValue'};
      final content = RelationshipChangeResponseContent.fromJson(json);
      expect(content, isA<ArbitraryRelationshipChangeResponseContent>());
    });
  });
}

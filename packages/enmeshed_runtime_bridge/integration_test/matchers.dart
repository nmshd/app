import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart' show Result;
import 'package:flutter_test/flutter_test.dart';

class _ResultFailingMatcher extends Matcher {
  final String code;

  _ResultFailingMatcher(this.code);

  @override
  Description describe(Description description) => description.add('result is failing');

  @override
  bool matches(item, Map matchState) => item is Result && item.isError && item.error.code == code;

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Result) return mismatchDescription.add('is not a Result');
    if (item.isSuccess) return mismatchDescription.add('is not failing');

    return mismatchDescription.add("has error code '${item.error.code}' but expected '$code'");
  }
}

Matcher isFailing(String code) => _ResultFailingMatcher(code);

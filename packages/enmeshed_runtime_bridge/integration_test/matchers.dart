import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart' show Result, VoidResult;
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

class _VoidResultFailingMatcher extends Matcher {
  final String code;

  _VoidResultFailingMatcher(this.code);

  @override
  Description describe(Description description) => description.add('result is failing');

  @override
  bool matches(item, Map matchState) => item is VoidResult && item.isError && item.error.code == code;

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! VoidResult) return mismatchDescription.add('is not a Result');
    if (item.isSuccess) return mismatchDescription.add('is not failing');

    return mismatchDescription.add("has error code '${item.error.code}' but expected '$code'");
  }
}

Matcher isFailingVoidResult(String code) => _VoidResultFailingMatcher(code);

class _ResultSuccessfulMatcher<T> extends Matcher {
  const _ResultSuccessfulMatcher();

  @override
  Description describe(Description description) => description.add('result is successful');

  @override
  bool matches(item, Map matchState) => (item is VoidResult && item.isSuccess) || (item is Result && item.isSuccess && item.value is T);

  @override
  Description describeMismatch(item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Result) return mismatchDescription.add('is not a Result');
    if (item.isError) return mismatchDescription.add("failed with code '${item.error.code}' and message '${item.error.message}'");

    return mismatchDescription.add('has value of type ${item.value.runtimeType}, but expected ${T.toString()}');
  }
}

Matcher isSuccessful<T>() => _ResultSuccessfulMatcher<T>();

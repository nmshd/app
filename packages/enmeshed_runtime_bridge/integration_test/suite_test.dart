@Timeout(Duration(minutes: 10))

import 'package:flutter_test/flutter_test.dart';

import 'data_view_expander_test/data_view_expander_test.dart' as data_view_expander_test;
import 'services/facades/facades_test.dart' as facades_test;
import 'setup.dart';

void main() async {
  final runtime = await setup();

  facades_test.run(runtime);
  data_view_expander_test.run(runtime);
}

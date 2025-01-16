import 'package:flutter/material.dart';

import 'custom_colors.dart';

extension GetCustomColors on BuildContext {
  CustomColors get customColors => Theme.of(this).extension<CustomColors>()!;
}

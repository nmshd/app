import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class TenTapDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback onTenTap;

  const TenTapDetector({required this.child, required this.onTenTap, super.key});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        SerialTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<SerialTapGestureRecognizer>(
          SerialTapGestureRecognizer.new,
          (instance) =>
              instance.onSerialTapDown = (details) {
                if (details.count == 10) onTenTap();
              },
        ),
      },
      child: child,
    );
  }
}

import 'package:enmeshed/core/utils/extensions.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.home_title), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: VectorGraphic(loader: AssetBytesLoader('assets/svg/error.svg'), height: 160),
            ),
            Gaps.h32,
            Text(
              textAlign: TextAlign.center,
              context.l10n.error_general,
            ),
            Gaps.h24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text('Supportseite', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor)),
                        Icon(Icons.arrow_outward, color: Theme.of(context).primaryColor),
                      ],
                    ),
                  ),
                ),
                Gaps.w8,
                FilledButton(
                  onPressed: () {
                    context.go('/splash');
                  },
                  child: Text(context.l10n.tryAgain),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../utils/extensions.dart';
import 'information_container.dart';

enum ScannerType {
  addContact,
  loadProfile;

  @override
  String toString() => name;
}

class InstructionsScreen extends StatefulWidget {
  final void Function(BuildContext) onContinue;
  final String title;
  final String subtitle;
  final List<String> instructions;
  final String informationTitle;
  final String informationDescription;
  final VectorGraphic illustration;
  final void Function()? deactivateHint;
  final bool showNumberedExplanation;
  final String? buttonContinueText;
  final bool informationContainerIsWarning;

  const InstructionsScreen({
    required this.onContinue,
    required this.title,
    required this.subtitle,
    required this.instructions,
    required this.informationTitle,
    required this.informationDescription,
    required this.illustration,
    this.deactivateHint,
    this.showNumberedExplanation = true,
    this.buttonContinueText,
    this.informationContainerIsWarning = false,
    super.key,
  });

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  bool _hideHints = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(icon: const Icon(Icons.clear), onPressed: () => context.pop()),
            Gaps.h4,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                maxLines: 2,
              ),
            ),
            Gaps.h24,
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InstructionHeader(illustration: widget.illustration, subtitle: widget.subtitle),
                        Gaps.h24,
                        if (widget.showNumberedExplanation)
                          _NumberedExplanation(instructions: widget.instructions)
                        else
                          _Explanation(instructions: widget.instructions),
                        Gaps.h8,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: InformationContainer(
                            title: widget.informationTitle,
                            description: widget.informationDescription,
                            warning: widget.informationContainerIsWarning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _InstructionsBottom(
              showCheckbox: widget.deactivateHint != null,
              hideHints: _hideHints,
              toggleHideHints: () => setState(() => _hideHints = !_hideHints),
              onContinue: () {
                if (_hideHints) widget.deactivateHint?.call();
                widget.onContinue(context);
              },
              buttonContinueText: widget.buttonContinueText,
            ),
          ],
        ),
      ),
    );
  }
}

class _InstructionHeader extends StatelessWidget {
  final String subtitle;
  final VectorGraphic illustration;

  const _InstructionHeader({required this.subtitle, required this.illustration});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: illustration),
        Gaps.h32,
        Text(subtitle, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
      ],
    );
  }
}

class _NumberedExplanation extends StatelessWidget {
  final List<String> instructions;

  const _NumberedExplanation({required this.instructions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        final itemNumber = index + 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$itemNumber. ', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary)),
            Expanded(child: Text(instructions.elementAt(index))),
          ],
        );
      },
      separatorBuilder: (context, index) => Gaps.h12,
      itemCount: instructions.length,
    );
  }
}

class _Explanation extends StatelessWidget {
  final List<String> instructions;

  const _Explanation({required this.instructions});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => Text(instructions.elementAt(index)),
      separatorBuilder: (context, index) => Gaps.h12,
      itemCount: instructions.length,
    );
  }
}

class _InstructionsBottom extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback toggleHideHints;
  final bool hideHints;
  final bool showCheckbox;
  final String? buttonContinueText;

  const _InstructionsBottom({
    required this.onContinue,
    required this.toggleHideHints,
    required this.hideHints,
    required this.showCheckbox,
    this.buttonContinueText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          if (showCheckbox) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: toggleHideHints,
                child: Row(
                  spacing: 4,
                  children: [
                    Checkbox(value: hideHints, onChanged: (_) => toggleHideHints()),
                    Expanded(child: Text(context.l10n.instructions_notShowAgain)),
                  ],
                ),
              ),
            ),
            Gaps.h8,
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                FilledButton(onPressed: onContinue, child: Text(buttonContinueText ?? context.l10n.instructions_scanQrCode)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

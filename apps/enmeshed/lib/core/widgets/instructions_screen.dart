import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

enum InstructionsType { addContact, loadProfile }

class InstructionsScreen extends StatelessWidget {
  final String accountId;
  final InstructionsType instructionsType;

  const InstructionsScreen({required this.accountId, required this.instructionsType, super.key});

  @override
  Widget build(BuildContext context) {
    if (instructionsType == InstructionsType.addContact) {
      return _InstructionsView(
        instructionsType: InstructionsType.addContact,
        accountId: accountId,
        title: context.l10n.instructions_addContact_title,
        subtitle: context.l10n.instructions_addContact_subtitle,
        informationTitle: context.l10n.instructions_addContact_information,
        informationDescription: context.l10n.instructions_addContact_informationDetails,
        illustration: const VectorGraphic(loader: AssetBytesLoader('assets/svg/connect_with_contact.svg'), height: 104),
        instructions: [
          context.l10n.instructions_addContact_scanQrCode,
          context.l10n.instructions_addContact_requestedData,
          context.l10n.instructions_addContact_chooseData,
          context.l10n.instructions_addContact_afterConfirmation,
        ],
      );
    } else {
      return _InstructionsView(
        instructionsType: InstructionsType.loadProfile,
        accountId: accountId,
        title: context.l10n.instructions_loadProfile_title,
        subtitle: context.l10n.instructions_loadProfile_subtitle,
        informationTitle: context.l10n.instructions_loadProfile_information,
        informationDescription: context.l10n.instructions_loadProfile_informationDetails,
        illustration: const VectorGraphic(loader: AssetBytesLoader('assets/svg/instructions_load_existing_profile.svg'), height: 104),
        instructions: [
          context.l10n.instructions_loadProfile_getDevice,
          context.l10n.instructions_loadProfile_createNewDevice,
          context.l10n.instructions_loadProfile_displayedQRCode,
          context.l10n.instructions_loadProfile_scanQRCode,
          context.l10n.instructions_loadProfile_confirmation,
        ],
      );
    }
  }
}

class _InstructionsView extends StatefulWidget {
  final String accountId;
  final String title;
  final String subtitle;
  final List<String> instructions;
  final String informationTitle;
  final String informationDescription;
  final VectorGraphic illustration;
  final InstructionsType instructionsType;

  const _InstructionsView({
    required this.accountId,
    required this.title,
    required this.subtitle,
    required this.instructions,
    required this.informationTitle,
    required this.informationDescription,
    required this.illustration,
    required this.instructionsType,
  });

  @override
  State<_InstructionsView> createState() => _InstructionsViewState();
}

class _InstructionsViewState extends State<_InstructionsView> {
  bool _hideHints = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.clear), onPressed: () => context.pop()),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InstructionHeader(illustration: widget.illustration, subtitle: widget.subtitle),
                        Gaps.h12,
                        _Explanation(instructions: widget.instructions),
                        Gaps.h32,
                        _InformationContainer(title: widget.informationTitle, description: widget.informationDescription),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h16,
            _InstructionsBottom(
              hideHints: _hideHints,
              toggleHideHints: () => setState(() => _hideHints = !_hideHints),
              onContinue: _onContinue,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onContinue() async {
    await upsertHintsSetting(accountId: widget.accountId, key: 'hints.${widget.instructionsType}', value: !_hideHints);

    if (mounted) {
      context.pop();
      unawaited(
        context.push(
          switch (widget.instructionsType) {
            InstructionsType.addContact => '/account/${widget.accountId}/scan',
            InstructionsType.loadProfile => '/scan',
          },
        ),
      );
    }
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
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ],
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
      itemBuilder: (_, index) {
        final itemNumber = index + 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$itemNumber. ',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            Expanded(child: Text(instructions.elementAt(index))),
          ],
        );
      },
      separatorBuilder: (context, index) => Gaps.h12,
      itemCount: instructions.length,
    );
  }
}

class _InformationContainer extends StatelessWidget {
  final String title;
  final String description;

  const _InformationContainer({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.secondary, size: 40),
                Gaps.w8,
                Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
            Gaps.h8,
            Text(description),
          ],
        ),
      ),
    );
  }
}

class _InstructionsBottom extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback toggleHideHints;
  final bool hideHints;

  const _InstructionsBottom({
    required this.onContinue,
    required this.toggleHideHints,
    required this.hideHints,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: toggleHideHints,
              child: Row(
                children: [
                  Checkbox(value: hideHints, onChanged: (_) => toggleHideHints()),
                  Gaps.w16,
                  Text(context.l10n.instructions_notShowAgain),
                ],
              ),
            ),
          ),
          Gaps.h24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                Gaps.w8,
                FilledButton(onPressed: onContinue, child: Text(context.l10n.instructions_scanQrCode)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

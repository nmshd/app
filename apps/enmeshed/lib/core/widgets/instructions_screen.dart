import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';

enum InstructionsType { addContact, loadProfile, createRecoveryKit }

class InstructionsScreen extends StatelessWidget {
  final String accountId;
  final InstructionsType instructionsType;

  const InstructionsScreen({required this.accountId, required this.instructionsType, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (instructionsType) {
      InstructionsType.addContact => _InstructionsView(
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
        ),
      InstructionsType.loadProfile => _InstructionsView(
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
        ),
      InstructionsType.createRecoveryKit => _InstructionsView(
          instructionsType: InstructionsType.createRecoveryKit,
          showNumberedExplanation: false,
          accountId: accountId,
          title: context.l10n.instructions_identityRecovery_title,
          subtitle: context.l10n.instructions_identityRecovery_subtitle,
          informationTitle: context.l10n.instructions_identityRecovery_information,
          informationDescription: context.l10n.instructions_identityRecovery_informationDescription,
          illustration: const VectorGraphic(loader: AssetBytesLoader('assets/svg/create_recovery_kit.svg'), height: 160),
          buttonContinueText: context.l10n.next,
          instructions: [
            context.l10n.instructions_identityRecovery_secure,
            context.l10n.instructions_identityRecovery_setup,
            context.l10n.instructions_identityRecovery_usage,
            context.l10n.instructions_identityRecovery_kitCreation,
          ],
        ),
    };
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
  final bool showNumberedExplanation;
  final String? buttonContinueText;

  const _InstructionsView({
    required this.accountId,
    required this.title,
    required this.subtitle,
    required this.instructions,
    required this.informationTitle,
    required this.informationDescription,
    required this.illustration,
    required this.instructionsType,
    this.showNumberedExplanation = true,
    this.buttonContinueText,
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
                        if (widget.showNumberedExplanation)
                          _NumberedExplanation(instructions: widget.instructions)
                        else
                          _Explanation(instructions: widget.instructions),
                        Gaps.h32,
                        InformationContainer(title: widget.informationTitle, description: widget.informationDescription),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h16,
            _InstructionsBottom(
              showCheckbox: widget.instructionsType != InstructionsType.createRecoveryKit,
              hideHints: _hideHints,
              toggleHideHints: () => setState(() => _hideHints = !_hideHints),
              onContinue: _onContinue,
              buttonContinueText: widget.buttonContinueText,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onContinue() async {
    if (widget.instructionsType == InstructionsType.createRecoveryKit) {
      await showCreateRecoveryKitModal(context: context, accountId: widget.accountId);

      return;
    }

    await upsertHintsSetting(accountId: widget.accountId, key: 'hints.${widget.instructionsType}', value: !_hideHints);

    if (mounted) {
      context.pop();
      unawaited(
        context.push(
          switch (widget.instructionsType) {
            InstructionsType.addContact => '/account/${widget.accountId}/scan',
            InstructionsType.loadProfile => '/scan',
            _ => '/scan',
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
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          if (showCheckbox)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
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
          Gaps.h8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                Gaps.w8,
                FilledButton(onPressed: onContinue, child: Text(buttonContinueText ?? context.l10n.instructions_scanQrCode)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

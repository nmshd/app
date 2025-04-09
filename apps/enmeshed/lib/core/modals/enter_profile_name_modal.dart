import 'package:enmeshed/core/utils/extensions.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<String?> showEnterProfileNameModal(BuildContext context) async {
  return showModalBottomSheet<String?>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (context) => const _EnterProfileNameModal(),
  );
}

class _EnterProfileNameModal extends StatefulWidget {
  const _EnterProfileNameModal();

  @override
  State<_EnterProfileNameModal> createState() => _EnterProfileNameModalState();
}

class _EnterProfileNameModalState extends State<_EnterProfileNameModal> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultProfileName = '${context.l10n.onboarding_defaultIdentityName} 1';

    return SafeArea(
      minimum: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.onboarding_enterProfileName, style: Theme.of(context).textTheme.titleLarge),
                Align(alignment: Alignment.centerRight, child: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLength: MaxLength.profileName,
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: defaultProfileName,
                    suffixIcon: IconButton(onPressed: _controller.clear, icon: const Icon(Icons.cancel_outlined)),
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onSubmitted: (text) => context.pop(text),
                ),
                Gaps.h16,
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () => context.pop(_controller.text.isEmpty ? defaultProfileName : _controller.text),
                    style: FilledButton.styleFrom(minimumSize: const Size(100, 36)),
                    child: Text(context.l10n.onboarding_acceptProfileName),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

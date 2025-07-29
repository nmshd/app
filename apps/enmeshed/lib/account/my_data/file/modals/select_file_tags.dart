import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import 'tag_label.dart';

Future<void> showSelectFileTags(
  BuildContext context, {
  required Set<String> availableTags,
  required Set<String> activeTags,
  required void Function(Set<String>) onApplyTags,
  required VoidCallback enableSelectTags,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _SelectFileTags(availableTags: availableTags, activeTags: activeTags, onApplyTags: onApplyTags),
  );
  enableSelectTags();
}

class _SelectFileTags extends StatefulWidget {
  final Set<String> availableTags;
  final Set<String> activeTags;
  final void Function(Set<String>) onApplyTags;

  const _SelectFileTags({required this.availableTags, required this.activeTags, required this.onApplyTags});

  @override
  State<_SelectFileTags> createState() => _SelectFileTagsState();
}

class _SelectFileTagsState extends State<_SelectFileTags> {
  Set<String> _selectedTags = {};

  @override
  void initState() {
    super.initState();

    _selectedTags = {...widget.activeTags};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.files_filter_byTag, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          if (widget.availableTags.isEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.files_filter_byTagEmpty, style: Theme.of(context).textTheme.bodyMedium),
                  Gaps.h32,
                  Center(
                    child: FilledButton(onPressed: () => context.pop(), child: Text(context.l10n.error_understood)),
                  ),
                ],
              ),
            )
          else
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      children: widget.availableTags.map((e) {
                        return FilterChip(
                          label: TagLabel(e),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: _selectedTags.contains(e)
                                  ? Theme.of(context).colorScheme.secondaryContainer
                                  : Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          showCheckmark: false,
                          selected: _selectedTags.contains(e),
                          onSelected: (_) => setState(() => _selectedTags.toggle(e)),
                        );
                      }).toList(),
                    ),
                    Gaps.h48,
                    Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
                        FilledButton(
                          onPressed: _selectedTags.isNotEmpty
                              ? () {
                                  widget.onApplyTags(_selectedTags);
                                  context.pop();
                                }
                              : null,
                          child: Text(context.l10n.apply_filter),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

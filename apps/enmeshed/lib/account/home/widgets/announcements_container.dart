import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AnnouncementContainer extends StatelessWidget {
  final List<AnnouncementDTO> announcements;

  const AnnouncementContainer({required this.announcements, super.key});

  @override
  Widget build(BuildContext context) {
    final widthFactor = announcements.length > 1 ? 0.9 : 1;
    final cardWidth = (MediaQuery.sizeOf(context).width - 32) * widthFactor; // 16 padding on each side

    return SizedBox(
      height: 210,
      child: ListView.separated(
        itemCount: announcements.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (_, index) => SizedBox(
          width: cardWidth,
          child: _AnnouncementCard(announcement: announcements[index]),
        ),
      ),
    );
  }
}

class _AnnouncementCard extends StatefulWidget {
  final AnnouncementDTO announcement;

  const _AnnouncementCard({required this.announcement});

  @override
  State<_AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<_AnnouncementCard> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (widget.announcement.severity) {
      AnnouncementSeverity.Low => Theme.of(context).colorScheme.primaryContainer,
      AnnouncementSeverity.Medium => context.customColors.warningContainer,
      AnnouncementSeverity.High => Theme.of(context).colorScheme.errorContainer,
    };

    final textColor = switch (widget.announcement.severity) {
      AnnouncementSeverity.Low => Theme.of(context).colorScheme.onPrimaryContainer,
      AnnouncementSeverity.Medium => context.customColors.onWarningContainer,
      AnnouncementSeverity.High => Theme.of(context).colorScheme.onErrorContainer,
    };

    return Container(
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 12).copyWith(bottom: widget.announcement.actions.isNotEmpty ? 0 : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
            child: Text(widget.announcement.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor), maxLines: 2),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Text(widget.announcement.body, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor)),
                ),
              ),
            ),
          ),
          if (widget.announcement.actions.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: _AnnouncementActionsButton(actions: widget.announcement.actions, textColor: textColor),
            ),
        ],
      ),
    );
  }
}

class _AnnouncementActionsButton extends StatelessWidget {
  final List<AnnouncementActionDTO> actions;
  final Color textColor;

  const _AnnouncementActionsButton({required this.actions, required this.textColor});

  @override
  Widget build(BuildContext context) {
    if (actions.length == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 4, right: 6, bottom: 4),
        child: TextButton.icon(
          icon: Icon(Icons.open_in_new, color: textColor),
          onPressed: () => GetIt.I.get<AbstractUrlLauncher>().launchUrl(Uri.parse(actions.first.link)),
          label: Text(actions.first.displayName, style: TextStyle(color: textColor)),
        ),
      );
    }

    final menuItems = actions.map(
      (action) => MenuItemButton(
        leadingIcon: const Icon(Icons.open_in_new),
        onPressed: () => GetIt.I.get<AbstractUrlLauncher>().launchUrl(Uri.parse(action.link)),
        child: Text(action.displayName),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(4),
      child: MenuAnchor(
        menuChildren: menuItems.toList(),
        consumeOutsideTap: true,
        builder: (context, controller, child) => IconButton(
          icon: Icon(Icons.more_vert, color: textColor),
          onPressed: () => controller.isOpen ? controller.close() : controller.open(),
        ),
      ),
    );
  }
}

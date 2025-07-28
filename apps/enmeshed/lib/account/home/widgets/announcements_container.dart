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
    const padding = 12.0;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.only(top: padding, bottom: padding - 4),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              widget.announcement.title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Text(
                    widget.announcement.body,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
              ),
            ),
          ),
          if (widget.announcement.actions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding).copyWith(right: widget.announcement.actions.length > 2 ? padding - 4 : null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  FilledButton(
                    onPressed: () => GetIt.I.get<AbstractUrlLauncher>().launchUrl(Uri.parse(widget.announcement.actions.first.link)),
                    child: Text(widget.announcement.actions.first.displayName),
                  ),
                  if (widget.announcement.actions.length == 2)
                    FilledButton(
                      onPressed: () => GetIt.I.get<AbstractUrlLauncher>().launchUrl(Uri.parse(widget.announcement.actions[1].link)),
                      child: Text(widget.announcement.actions[1].displayName),
                    )
                  else if (widget.announcement.actions.length > 2)
                    MenuAnchor(
                      menuChildren: widget.announcement.actions.skip(1).map((action) {
                        return MenuItemButton(
                          onPressed: () => GetIt.I.get<AbstractUrlLauncher>().launchUrl(Uri.parse(action.link)),
                          child: Text(action.displayName),
                        );
                      }).toList(),
                      consumeOutsideTap: true,
                      builder: (context, controller, child) => IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
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

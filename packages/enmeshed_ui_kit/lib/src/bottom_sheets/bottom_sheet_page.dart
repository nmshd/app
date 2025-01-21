import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  final BottomSheetPageHeader header;
  final Widget content;
  final Widget? bottom;

  const BottomSheetPage({
    required this.header,
    required this.content,
    this.bottom,
    super.key,
  });

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.header,
            Flexible(child: Scrollbar(thumbVisibility: true, child: SingleChildScrollView(child: widget.content))),
            if (widget.bottom != null) Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: widget.bottom!),
          ],
        ),
      ),
    );
  }
}

class BottomSheetPageHeader extends StatelessWidget {
  final String title;

  final bool showBackButton;
  final bool showCloseButton;
  final VoidCallback? onBack;

  const BottomSheetPageHeader({
    required this.title,
    this.showBackButton = true,
    this.showCloseButton = true,
    this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: onBack == null ? 24 : 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onBack != null) IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
          Text(title, style: onBack == null ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium),
          if (showCloseButton)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }
}

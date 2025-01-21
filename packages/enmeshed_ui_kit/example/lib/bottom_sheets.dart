import 'package:enmeshed_ui_kit/enmeshed_ui_kit.dart';
import 'package:flutter/material.dart';

class BottomSheets extends StatefulWidget {
  const BottomSheets({super.key});

  @override
  State<BottomSheets> createState() => _BottomSheetsState();
}

class _BottomSheetsState extends State<BottomSheets> {
  int count = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(onPressed: () => SimpleBottomSheet.show(context), child: Text('Simple Bottom Sheet')),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () => setState(() => count--), icon: Icon(Icons.remove)),
                FilledButton(onPressed: () => LongBottomSheet.show(context, count), child: Text('Long Bottom Sheet ($count)')),
                IconButton(onPressed: () => setState(() => count++), icon: Icon(Icons.add)),
              ],
            ),
            FilledButton(onPressed: () => MultiPageSheet.show(context), child: Text('Multi Page Sheet')),
          ],
        ),
      ),
    );
  }
}

class SimpleBottomSheet extends StatelessWidget {
  const SimpleBottomSheet._();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SimpleBottomSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetPage(
      header: BottomSheetPageHeader(title: 'Title'),
      content: Text('Simple Bottom Sheet'),
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close')),
        ],
      ),
    );
  }
}

class LongBottomSheet extends StatelessWidget {
  final int count;

  const LongBottomSheet._({required this.count});

  static void show(BuildContext context, int count) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => LongBottomSheet._(count: count),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetPage(
      header: BottomSheetPageHeader(title: 'Title'),
      content: Column(
        children: [
          for (var i = 1; i <= count; i++) ListTile(title: Text('Item $i')),
        ],
      ),
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close')),
        ],
      ),
    );
  }
}

class MultiPageSheet extends StatefulWidget {
  const MultiPageSheet._();

  static void show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => MultiPageSheet._(),
    );
  }

  @override
  State<MultiPageSheet> createState() => _MultiPageSheetState();
}

class _MultiPageSheetState extends State<MultiPageSheet> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final mainPage = Column(
      children: [
        for (var i = 1; i <= 10; i++) ListTile(title: Hero(tag: Key('$page'), child: Text('Page $i')), onTap: () => _navigateToPage(i)),
      ],
    );

    return BottomSheetPage(
      header: BottomSheetPageHeader(title: 'Title', onBack: page > 0 ? () => _navigateToPage(0) : null),
      content: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          width: double.infinity,
          child: page == 0
              ? mainPage
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Hero(tag: Key('$page'), child: Text('Page $page'))),
                ),
        ),
      ),
      bottom: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(onPressed: () => Navigator.of(context).pop(), child: Text('Close')),
        ],
      ),
    );
  }

  void _navigateToPage(int page) => setState(() => this.page = page);
}

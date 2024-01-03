import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../abstract_url_launcher.dart';
import '../widgets/custom_list_tile.dart';

class ConsentRequestItemRenderer extends StatelessWidget {
  final ConsentRequestItemDVO item;

  const ConsentRequestItemRenderer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: item.name,
      description: item.description,
      thirdLine: item.consent,
      trailing: item.link != null
          ? IconButton(
              onPressed: () async {
                final url = Uri.parse(item.link!);
                await GetIt.I.get<AbstractUrlLauncher>().launchSafe(url);
              },
              icon: const Icon(Icons.open_in_new),
            )
          : null,
    );
  }
}

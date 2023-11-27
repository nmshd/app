import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../widgets/custom_list_tile.dart';
import '/src/request_renderer_controller.dart';
import '/src/url_launcher.dart';

class ConsentRequestItemRenderer extends StatelessWidget {
  final ConsentRequestItemDVO item;
  final RequestRendererController? controller;

  const ConsentRequestItemRenderer({super.key, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: item.consent,
      description: item.description,
      trailing: item.link != null
          ? IconButton(
              onPressed: () async {
                final url = Uri.parse(item.link!);
                final urlLauncher = GetIt.I.get<AbstractUrlLauncher>();

                if (!await urlLauncher.canLaunchUrl(url)) {
                  GetIt.I.get<Logger>().e('Could not launch $url');
                  return;
                }
                try {
                  await urlLauncher.launchUrl(url);
                } catch (e) {
                  GetIt.I.get<Logger>().e(e);
                }
              },
              icon: const Icon(Icons.open_in_new),
            )
          : null,
    );
  }
}

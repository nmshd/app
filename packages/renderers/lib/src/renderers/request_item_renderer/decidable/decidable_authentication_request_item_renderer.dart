import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/widgets.dart';

import '../../../../renderers.dart';
import '../../widgets/custom_list_tile.dart';

class DecidableAuthenticationRequestItemRenderer extends StatefulWidget {
  final DecidableAuthenticationRequestItemDVO item;
  final RequestRendererController? controller;
  final RequestItemIndex itemIndex;

  const DecidableAuthenticationRequestItemRenderer({
    super.key,
    required this.item,
    this.controller,
    required this.itemIndex,
  });

  @override
  State<DecidableAuthenticationRequestItemRenderer> createState() => _DecidableAuthenticationRequestItemRendererState();
}

class _DecidableAuthenticationRequestItemRendererState extends State<DecidableAuthenticationRequestItemRenderer> {
  @override
  void initState() {
    super.initState();

    if (widget.itemIndex.innerIndex != null) {
      final groupIndex = widget.itemIndex.innerIndex!;
      final controllerValue = widget.controller?.value?.items[groupIndex] as DecideRequestItemGroupParameters;
      controllerValue.items[widget.itemIndex.rootIndex] = const AcceptRequestItemParameters();
    }

    widget.controller?.value?.items[widget.itemIndex.rootIndex] = const AcceptRequestItemParameters();
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(title: '', subTitle: widget.item.name);
  }
}

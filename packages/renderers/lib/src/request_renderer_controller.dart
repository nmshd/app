import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'request_item_index.dart';

class RequestRendererController extends ValueNotifier<DecideRequestParameters?> {
  RequestRendererController() : super(null);

  writeAtIndex({required RequestItemIndex index, required DecideRequestItemParameters value}) {
    if (index.innerIndex == null) {
      this.value?.items[index.rootIndex] = value;
    } else {
      final groupItem = this.value?.items[index.rootIndex];
      if (groupItem is! DecideRequestItemGroupParameters) {
        throw Exception("Invalid type '${groupItem.runtimeType}' but expected 'DecideRequestItemGroupParameters'");
      }

      groupItem.items[index.innerIndex!] = value;
    }

    notifyListeners();
  }
}

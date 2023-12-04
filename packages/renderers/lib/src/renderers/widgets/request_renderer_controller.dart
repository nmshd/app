import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import 'request_item_index.dart';

class RequestRendererController extends ValueNotifier<DecideRequestParameters> {
  final DecideRequestParameters rejectParams;

  RequestRendererController({required LocalRequestDVO request})
      : rejectParams = _composeRejectItems(request),
        super(_composeRejectItems(request));

  writeAtIndex({required RequestItemIndex index, required DecideRequestItemParameters value}) {
    if (index.innerIndex == null) {
      this.value.items[index.rootIndex] = value;
    } else {
      final groupItem = this.value.items[index.rootIndex];
      if (groupItem is! DecideRequestItemGroupParameters) {
        throw Exception("Invalid type '${groupItem.runtimeType}' but expected 'DecideRequestItemGroupParameters'");
      }

      groupItem.items[index.innerIndex!] = value;
    }

    notifyListeners();
  }

  static DecideRequestParameters _composeRejectItems(LocalRequestDVO request) {
    final rejectItems = List<DecideRequestParametersItem>.from(request.items.map((e) {
      if (e is RequestItemGroupDVO) {
        return DecideRequestItemGroupParameters(
          items: List<DecideRequestItemParameters>.from(e.items.map((e) => const RejectRequestItemParameters())),
        );
      }

      return const RejectRequestItemParameters();
    }));

    return DecideRequestParameters(requestId: request.id, items: rejectItems);
  }
}

import 'package:enmeshed_types/enmeshed_types.dart';

import '../../../request_item_index.dart';
import '../../../request_renderer_controller.dart';

void handleCheckboxChange({
  required bool isChecked,
  RequestRendererController? controller,
  required RequestItemIndex itemIndex,
  AcceptRequestItemParameters acceptRequestItemParameter = const AcceptRequestItemParameters(),
}) {
  if (isChecked) {
    controller?.writeAtIndex(
      index: itemIndex,
      value: acceptRequestItemParameter,
    );
  } else {
    controller?.writeAtIndex(
      index: itemIndex,
      value: const RejectRequestItemParameters(),
    );
  }
}

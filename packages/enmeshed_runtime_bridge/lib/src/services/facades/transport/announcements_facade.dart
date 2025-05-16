import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class AnnouncementsFacade {
  final AbstractEvaluator _evaluator;
  AnnouncementsFacade(this._evaluator);

  Future<Result<List<AnnouncementDTO>>> getAnnouncements({Map<String, QueryValue>? query}) async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.announcements.getAnnouncements(request)
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
      arguments: {
        'request': {if (query != null) 'query': query.toJson()},
      },
    );

    final json = result.valueToMap();
    return Result.fromJson(json, (value) => List<AnnouncementDTO>.from(value.map((e) => AnnouncementDTO.fromJson(e))));
  }
}

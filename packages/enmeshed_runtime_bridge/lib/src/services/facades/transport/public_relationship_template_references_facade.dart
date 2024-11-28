import 'package:enmeshed_types/enmeshed_types.dart';

import '../abstract_evaluator.dart';
import '../handle_call_async_js_result.dart';
import '../utilities/utilities.dart';

class PublicRelationshipTemplateReferencesFacade {
  final AbstractEvaluator _evaluator;
  PublicRelationshipTemplateReferencesFacade(this._evaluator);

  Future<Result<List<PublicRelationshipTemplateReferenceDTO>>> getPublicRelationshipTemplateReferences() async {
    final result = await _evaluator.evaluateJavaScript(
      '''const result = await session.transportServices.publicRelationshipTemplateReferences.getPublicRelationshipTemplateReferences()
      if (result.isError) return { error: { message: result.error.message, code: result.error.code } }
      return { value: result.value }''',
    );

    final json = result.valueToMap();
    return Result.fromJson(
      json,
      (value) => List<PublicRelationshipTemplateReferenceDTO>.from(value.map((e) => PublicRelationshipTemplateReferenceDTO.fromJson(e))),
    );
  }
}

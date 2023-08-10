import 'package:enmeshed_types/enmeshed_types.dart';

import 'services/services.dart';

class DataViewExpander {
  final AbstractEvaluator _evaluator;
  DataViewExpander(this._evaluator);

  // TODO: find a way to make this work as dart will now allow us to implement this properly
  // expand(content: any, expectedType?: string): Promise<DataViewObject | DataViewObject[]>;

  /// Takes a [MessageDTO] or [MessageWithAttachmentsDTO].
  /// Will return a [MessageDVO], [MailDVO] or [RequestMessageDVO].
  Future<MessageDVO> expandMessageDTO(
    /// can be a [MessageDTO] or a [MessageWithAttachmentsDTO]
    dynamic message,
  ) async {
    assert(message is MessageDTO || message is MessageWithAttachmentsDTO, 'message must be a MessageDTO or MessageWithAttachmentsDTO');

    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandMessageDTO(message)',
      arguments: {'message': message.toJson()},
    );

    final value = result.valueToMap();
    return MessageDVO.fromJson(value);
  }

  /// Returns a list containing [MessageDVO]s, [MailDVO]s and [RequestMessageDVO]s.
  Future<List<MessageDVO>> expandMessageDTOs(List<MessageDTO> messages) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandMessageDTOs(messages)',
      arguments: {'messages': messages.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => MessageDVO.fromJson(e)).toList();
  }

  /// Returns a [PeerRelationshipTemplateDVO] or [RelationshipTemplateDVO].
  Future<RelationshipTemplateDVO> expandRelationshipTemplateDTO(RelationshipTemplateDTO template) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipTemplateDTO(template)',
      arguments: {'template': template.toJson()},
    );

    final value = result.valueToMap();
    return RelationshipTemplateDVO.fromJson(value);
  }

  // expandRelationshipTemplateDTOs(templates: RelationshipTemplateDTO[]): Promise<(PeerRelationshipTemplateDVO | RelationshipTemplateDVO)[]>;
  /// Will return a List containing [PeerRelationshipTemplateDVO]s and [RelationshipTemplateDVO]s.
  Future<List<RelationshipTemplateDVO>> expandRelationshipTemplateDTOs(List<RelationshipTemplateDTO> templates) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipTemplateDTOs(templates)',
      arguments: {'templates': templates.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => RelationshipTemplateDVO.fromJson(e)).toList();
  }

  Future<RequestDVO> expandRequest(Request request) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRequest(request)',
      arguments: {'request': request.toJson()},
    );

    final value = result.valueToMap();
    return RequestDVO.fromJson(value);
  }

  Future<List<RequestDVO>> expandRequests(List<Request> requests) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRequests(requests)',
      arguments: {'requests': requests.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => RequestDVO.fromJson(e)).toList();
  }

  Future<RequestItemDVO> expandRequestItem(RequestItem requestItem) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRequestItem(requestItem)',
      arguments: {'requestItem': requestItem.toJson()},
    );

    final value = result.valueToMap();
    return RequestItemDVO.fromJson(value);
  }

  // TODO: find a way to make this work as dart will now allow us to implement this properly
  // expandRequestGroupOrItem(requestGroupOrItem: RequestItemGroupJSON | RequestItemJSON, localRequestDTO?: LocalRequestDTO, responseGroupOrItemDVO?: ResponseItemDVO | ResponseItemGroupDVO): Promise<RequestItemGroupDVO | RequestItemDVO>;

  Future<ResponseItemDVO> expandResponseItem(ResponseItem responseItem) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandResponseItem(responseItem)',
      arguments: {'responseItem': responseItem.toJson()},
    );

    final value = result.valueToMap();
    return ResponseItemDVO.fromJson(value);
  }

  Future<LocalAttributeListenerDVO> expandLocalAttributeListenerDTO(LocalAttributeListenerDTO attributeListener) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandLocalAttributeListenerDTO(attributeListener)',
      arguments: {'attributeListener': attributeListener.toJson()},
    );

    final value = result.valueToMap();
    return LocalAttributeListenerDVO.fromJson(value);
  }

  // dart will now allow us to implement this properly
  // expandResponseGroupOrItem(responseGroupOrItem: ResponseItemGroupJSON | ResponseItemJSON): Promise<ResponseItemGroupDVO | ResponseItemDVO>;

  Future<LocalRequestDVO> expandLocalRequestDTO(LocalRequestDTO request) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandLocalRequestDTO(request)',
      arguments: {'request': request.toJson()},
    );

    final value = result.valueToMap();
    return LocalRequestDVO.fromJson(value);
  }

  Future<List<LocalRequestDVO>> expandLocalRequestDTOs(List<LocalRequestDTO> localRequests) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandLocalRequestDTOs(localRequests)',
      arguments: {'localRequests': localRequests.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => LocalRequestDVO.fromJson(e)).toList();
  }

  Future<ResponseDVO> expandResponse(Response response, LocalRequestDTO request) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandResponse(response, request)',
      arguments: {'response': response.toJson(), 'request': request.toJson()},
    );

    final value = result.valueToMap();
    return ResponseDVO.fromJson(value);
  }

  Future<LocalResponseDVO> expandLocalResponseDTO(LocalResponseDTO response, LocalRequestDTO request) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandLocalResponseDTO(response, request)',
      arguments: {'response': response.toJson(), 'request': request.toJson()},
    );

    final value = result.valueToMap();
    return LocalResponseDVO.fromJson(value);
  }

  Future<LocalAttributeDVO> expandLocalAttributeDTO(LocalAttributeDTO attribute) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandLocalAttributeDTO(attribute)',
      arguments: {'attribute': attribute.toJson()},
    );

    final value = result.valueToMap();
    return LocalAttributeDVO.fromJson(value);
  }

  Future<List<LocalAttributeDVO>> expandLocalAttributeDTOs(List<LocalAttributeDTO> attributes) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandLocalAttributeDTOs(attributes)',
      arguments: {'attributes': attributes.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => LocalAttributeDVO.fromJson(e)).toList();
  }

  Future<AttributeQueryDVO> expandAttributeQuery(AttributeQuery query) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return AttributeQueryDVO.fromJson(value);
  }

  Future<IdentityAttributeQueryDVO> expandIdentityAttributeQuery(IdentityAttributeQuery query) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandIdentityAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return IdentityAttributeQueryDVO.fromJson(value);
  }

  Future<RelationshipAttributeQueryDVO> expandRelationshipAttributeQuery(RelationshipAttributeQuery query) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return RelationshipAttributeQueryDVO.fromJson(value);
  }

  Future<ThirdPartyRelationshipAttributeQueryDVO> expandThirdPartyRelationshipAttributeQuery(ThirdPartyRelationshipAttributeQuery query) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandThirdPartyRelationshipAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return ThirdPartyRelationshipAttributeQueryDVO.fromJson(value);
  }

  Future<ProcessedAttributeQueryDVO> processAttributeQuery(AttributeQuery attributeQuery) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.processAttributeQuery(attributeQuery)',
      arguments: {'attributeQuery': attributeQuery.toJson()},
    );

    final value = result.valueToMap();
    return ProcessedAttributeQueryDVO.fromJson(value);
  }

  Future<ProcessedIdentityAttributeQueryDVO> processIdentityAttributeQuery(IdentityAttributeQuery query) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.processIdentityAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return ProcessedIdentityAttributeQueryDVO.fromJson(value);
  }

  Future<ProcessedRelationshipAttributeQueryDVO> processRelationshipAttributeQuery(RelationshipAttributeQuery query) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.processRelationshipAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return ProcessedRelationshipAttributeQueryDVO.fromJson(value);
  }

  Future<ProcessedThirdPartyRelationshipAttributeQueryDVO> processThirdPartyRelationshipAttributeQuery(
    ThirdPartyRelationshipAttributeQuery query,
  ) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.processThirdPartyRelationshipAttributeQuery(query)',
      arguments: {'query': query.toJson()},
    );

    final value = result.valueToMap();
    return ProcessedThirdPartyRelationshipAttributeQueryDVO.fromJson(value);
  }

  Future<DraftIdentityAttributeDVO> expandAttribute(AbstractAttribute attribute) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandAttribute(attribute)',
      arguments: {'attribute': attribute.toJson()},
    );

    final value = result.valueToMap();
    return DraftIdentityAttributeDVO.fromJson(value);
  }

  Future<List<DraftIdentityAttributeDVO>> expandAttributes(List<AbstractAttribute> attributes) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandAttributes(attributes)',
      arguments: {'attributes': attributes.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => DraftIdentityAttributeDVO.fromJson(e)).toList();
  }

  Future<IdentityDVO> expandSelf() async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandSelf()',
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  Future<IdentityDVO> expandUnknown(String address) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandUnknown(address)',
      arguments: {'address': address},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  Future<IdentityDVO> expandAddress(String address) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandAddress(address)',
      arguments: {'address': address},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  Future<List<IdentityDVO>> expandAddresses(List<String> addresses) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandAddresses(addresses)',
      arguments: {'addresses': addresses},
    );

    final value = result.valueToList();
    return value.map((e) => IdentityDVO.fromJson(e)).toList();
  }

  Future<RecipientDVO> expandRecipientDTO(RecipientDTO recipient) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRecipientDTO(recipient)',
      arguments: {'recipient': recipient.toJson()},
    );

    final value = result.valueToMap();
    return RecipientDVO.fromJson(value);
  }

  Future<List<RecipientDVO>> expandRecipientDTOs(List<RecipientDTO> recipients) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRecipientDTOs(recipients)',
      arguments: {'recipients': recipients.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => RecipientDVO.fromJson(e)).toList();
  }

  Future<RelationshipChangeDVO> expandRelationshipChangeDTO(RelationshipDTO relationship, RelationshipChangeDTO change) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipChangeDTO(relationship, change)',
      arguments: {'relationship': relationship.toJson(), 'change': change.toJson()},
    );

    final value = result.valueToMap();
    return RelationshipChangeDVO.fromJson(value);
  }

  Future<List<RelationshipChangeDVO>> expandRelationshipChangeDTOs(RelationshipDTO relationship) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipChangeDTOs(relationship)',
      arguments: {'relationship': relationship.toJson()},
    );

    final value = result.valueToList();
    return value.map((e) => RelationshipChangeDVO.fromJson(e)).toList();
  }

  Future<IdentityDVO> expandRelationshipDTO(RelationshipDTO relationship) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipDTO(relationship)',
      arguments: {'relationship': relationship.toJson()},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  Future<IdentityDVO> expandIdentityForAddress(String address) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandIdentityForAddress(address)',
      arguments: {'address': address},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  Future<IdentityDVO> expandIdentityDTO(IdentityDTO identity) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandIdentityDTO(identity)',
      arguments: {'identity': identity.toJson()},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  Future<List<IdentityDVO>> expandRelationshipDTOs(List<RelationshipDTO> relationships) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandRelationshipDTOs(relationships)',
      arguments: {'relationships': relationships.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => IdentityDVO.fromJson(e)).toList();
  }

  Future<FileDVO> expandFileId(String id) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandFileId(id)',
      arguments: {'id': id},
    );

    final value = result.valueToMap();
    return FileDVO.fromJson(value);
  }

  Future<List<FileDVO>> expandFileIds(List<String> ids) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandFileIds(ids)',
      arguments: {'ids': ids},
    );

    final value = result.valueToList();
    return value.map((e) => FileDVO.fromJson(e)).toList();
  }

  Future<FileDVO> expandFileDTO(FileDTO file) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandFileDTO(file)',
      arguments: {'file': file.toJson()},
    );

    final value = result.valueToMap();
    return FileDVO.fromJson(value);
  }

  Future<List<FileDVO>> expandFileDTOs(List<FileDTO> files) async {
    final result = await _evaluator.evaluateJavaScript(
      'return await session.expander.expandFileDTOs(files)',
      arguments: {'files': files.map((e) => e.toJson()).toList()},
    );

    final value = result.valueToList();
    return value.map((e) => FileDVO.fromJson(e)).toList();
  }
}

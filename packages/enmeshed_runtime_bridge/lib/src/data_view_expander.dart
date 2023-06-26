import 'package:enmeshed_types/enmeshed_types.dart';

import 'services/services.dart';

class DataViewExpander {
  final AbstractEvaluator _evaluator;
  DataViewExpander(this._evaluator);

  // dart will now allow us to implement this properly
  // expand(content: any, expectedType?: string): Promise<DataViewObject | DataViewObject[]>;

  // expandMessageDTO(message: MessageDTO | MessageWithAttachmentsDTO): Promise<MessageDVO | MailDVO | RequestMessageDVO>;
  // expandMessageDTOs(messages: MessageDTO[]): Promise<(MessageDVO | MailDVO | RequestMessageDVO)[]>;
  // expandRelationshipTemplateDTO(template: RelationshipTemplateDTO): Promise<PeerRelationshipTemplateDVO | RelationshipTemplateDVO>;
  // expandRelationshipTemplateDTOs(templates: RelationshipTemplateDTO[]): Promise<(PeerRelationshipTemplateDVO | RelationshipTemplateDVO)[]>;
  // expandRequest(request: RequestJSON, localRequestDTO?: LocalRequestDTO, localResponseDVO?: LocalResponseDVO): Promise<RequestDVO>;
  // expandRequests(requests: RequestJSON[]): Promise<RequestDVO[]>;
  // expandRequestItem(requestItem: RequestItemJSON, localRequestDTO?: LocalRequestDTO, responseItemDVO?: ResponseItemDVO): Promise<RequestItemDVO>;
  // expandRequestGroupOrItem(requestGroupOrItem: RequestItemGroupJSON | RequestItemJSON, localRequestDTO?: LocalRequestDTO, responseGroupOrItemDVO?: ResponseItemDVO | ResponseItemGroupDVO): Promise<RequestItemGroupDVO | RequestItemDVO>;
  // expandResponseItem(responseItem: ResponseItemJSON): Promise<ResponseItemDVO>;
  // expandLocalAttributeListenerDTO(attributeListener: LocalAttributeListenerDTO): Promise<LocalAttributeListenerDVO>;
  // expandResponseGroupOrItem(responseGroupOrItem: ResponseItemGroupJSON | ResponseItemJSON): Promise<ResponseItemGroupDVO | ResponseItemDVO>;
  // expandLocalRequestDTO(request: LocalRequestDTO): Promise<LocalRequestDVO>;
  // expandLocalRequestDTOs(localRequests: LocalRequestDTO[]): Promise<LocalRequestDVO[]>;
  // expandResponse(response: ResponseJSON, request: LocalRequestDTO): Promise<ResponseDVO>;
  // expandLocalResponseDTO(response: LocalResponseDTO, request: LocalRequestDTO): Promise<LocalResponseDVO>;
  // expandLocalAttributeDTO(attribute: LocalAttributeDTO): Promise<RepositoryAttributeDVO | SharedToPeerAttributeDVO | PeerAttributeDVO | PeerRelationshipAttributeDVO | OwnRelationshipAttributeDVO>;
  // expandLocalAttributeDTOs(attributes: LocalAttributeDTO[]): Promise<(RepositoryAttributeDVO | SharedToPeerAttributeDVO | PeerAttributeDVO | PeerRelationshipAttributeDVO | OwnRelationshipAttributeDVO)[]>;
  // expandAttributeQuery(query: IdentityAttributeQueryJSON | RelationshipAttributeQueryJSON | ThirdPartyRelationshipAttributeQueryJSON): Promise<AttributeQueryDVO>;
  // expandIdentityAttributeQuery(query: IdentityAttributeQueryJSON): IdentityAttributeQueryDVO;
  // expandRelationshipAttributeQuery(query: RelationshipAttributeQueryJSON): Promise<RelationshipAttributeQueryDVO>;
  // expandThirdPartyRelationshipAttributeQuery(query: ThirdPartyRelationshipAttributeQueryJSON): Promise<ThirdPartyRelationshipAttributeQueryDVO>;
  // processAttributeQuery(attributeQuery: IdentityAttributeQueryJSON | RelationshipAttributeQueryJSON | ThirdPartyRelationshipAttributeQueryJSON): Promise<ProcessedAttributeQueryDVO>;
  // processIdentityAttributeQuery(query: IdentityAttributeQueryJSON): Promise<ProcessedIdentityAttributeQueryDVO>;
  // processRelationshipAttributeQuery(query: RelationshipAttributeQueryJSON): Promise<ProcessedRelationshipAttributeQueryDVO>;
  // processThirdPartyRelationshipAttributeQuery(query: ThirdPartyRelationshipAttributeQueryJSON): Promise<ProcessedThirdPartyRelationshipAttributeQueryDVO>;
  // expandAttribute(attribute: IdentityAttributeJSON | RelationshipAttributeJSON): Promise<DraftIdentityAttributeDVO | DraftRelationshipAttributeDVO>;
  // expandAttributes(attributes: (IdentityAttributeJSON | RelationshipAttributeJSON)[]): Promise<(DraftIdentityAttributeDVO | DraftRelationshipAttributeDVO)[]>;

  // expandSelf(): IdentityDVO;
  Future<IdentityDVO> expandSelf() async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.expander.expandSelf()
      return result;''',
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  // expandUnknown(address: string): IdentityDVO;
  Future<IdentityDVO> expandUnknown(String address) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.expander.expandUnknown(address)
      return result;''',
      arguments: {'address': address},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  // expandAddress(address: string): Promise<IdentityDVO>;
  Future<IdentityDVO> expandAddress(String address) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.expander.expandAddress(address)
      return result;''',
      arguments: {'address': address},
    );

    final value = result.valueToMap();
    return IdentityDVO.fromJson(value);
  }

  // expandAddresses(addresses: string[]): Promise<IdentityDVO[]>;
  Future<List<IdentityDVO>> expandAddresses(List<String> addresses) async {
    final result = await _evaluator.evaluateJavascript(
      '''const result = await session.expander.expandAddresses(addresses)
      return result;''',
      arguments: {'addresses': addresses},
    );

    final value = result.valueToList();
    return value.map((e) => IdentityDVO.fromJson(e)).toList();
  }

  // expandRecipientDTO(recipient: RecipientDTO): Promise<RecipientDVO>;
  // expandRecipientDTOs(recipients: RecipientDTO[]): Promise<RecipientDVO[]>;
  // expandRelationshipChangeDTO(relationship: RelationshipDTO, change: RelationshipChangeDTO): Promise<RelationshipChangeDVO>;
  // expandRelationshipChangeDTOs(relationship: RelationshipDTO): Promise<RelationshipChangeDVO[]>;
  // expandRelationshipDTO(relationship: RelationshipDTO): Promise<IdentityDVO>;
  // expandIdentityForAddress(address: string): Promise<IdentityDVO>;
  // expandIdentityDTO(identity: IdentityDTO): Promise<IdentityDVO>;
  // expandRelationshipDTOs(relationships: RelationshipDTO[]): Promise<IdentityDVO[]>;
  // expandFileId(id: string): Promise<FileDVO>;
  // expandFileIds(ids: string[]): Promise<FileDVO[]>;
  // expandFileDTO(file: FileDTO): Promise<FileDVO>;
  // expandFileDTOs(files: FileDTO[]): Promise<FileDVO[]>;
}

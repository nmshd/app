import 'package:enmeshed_types/enmeshed_types.dart';

FileDTO fileTransformer(dynamic v) => FileDTO.fromJson(v);
List<FileDTO> fileListTransformer(dynamic v) => List<FileDTO>.from(v.map(fileTransformer));

TokenDTO tokenTransformer(dynamic v) => TokenDTO.fromJson(v);
List<TokenDTO> tokenListTransformer(dynamic v) => List<TokenDTO>.from(v.map(tokenTransformer));

RelationshipDTO relationshipTransformer(dynamic v) => RelationshipDTO.fromJson(v);
List<RelationshipDTO> relationshipListTransformer(dynamic v) => List<RelationshipDTO>.from(v.map(relationshipTransformer));

LocalAttributeDTO localAttributeTransformer(dynamic v) => LocalAttributeDTO.fromJson(v);
List<LocalAttributeDTO> localAttributeListTransformer(dynamic v) => List<LocalAttributeDTO>.from(v.map(localAttributeTransformer));

RelationshipTemplateDTO relationshipTemplateTransformer(dynamic v) => RelationshipTemplateDTO.fromJson(v);
List<RelationshipTemplateDTO> relationshipTemplateListTransformer(dynamic v) => List<RelationshipTemplateDTO>.from(
      v.map(relationshipTemplateTransformer),
    );

LocalRequestDTO localRequestTransformer(dynamic v) => LocalRequestDTO.fromJson(v);
List<LocalRequestDTO> localRequestListTransformer(dynamic v) => List<LocalRequestDTO>.from(v.map(localRequestTransformer));

RequestValidationResultDTO requestValidationResultTransformer(dynamic v) => RequestValidationResultDTO.fromJson(v);

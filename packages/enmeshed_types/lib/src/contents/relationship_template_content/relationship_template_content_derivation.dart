import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../arbitrary_content_json.dart';
import '../contents.dart';

part 'relationship_template_content.dart';

abstract class RelationshipTemplateContentDerivation extends Equatable {
  const RelationshipTemplateContentDerivation();

  factory RelationshipTemplateContentDerivation.fromJson(Map json) {
    final type = json['@type'];

    return switch (type) {
      'RelationshipTemplateContent' => RelationshipTemplateContent.fromJson(json),
      'ArbitraryRelationshipTemplateContent' => ArbitraryRelationshipTemplateContent.fromJson(json),
      _ => throw Exception('Unknown type: $type'),
    };
  }

  Map<String, dynamic> toJson();

  @mustCallSuper
  @override
  List<Object?> get props;
}

class ArbitraryRelationshipTemplateContent extends RelationshipTemplateContentDerivation with ArbitraryContentJSON {
  @override
  final Map<String, dynamic> value;

  ArbitraryRelationshipTemplateContent(Map value) : value = Map<String, dynamic>.from(value);

  factory ArbitraryRelationshipTemplateContent.fromJson(Map json) => ArbitraryRelationshipTemplateContent(json['value']);

  @override
  Map<String, dynamic> toJson() => {'@type': 'ArbitraryRelationshipTemplateContent', 'value': value};

  @override
  List<Object?> get props => [value];
}

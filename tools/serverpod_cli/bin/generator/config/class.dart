import 'package:schemed_annotation/schemed_annotation.dart';

import '../../util/yaml_docs.dart';
import 'fields.dart';
import 'files.dart';
import 'index.dart';

part 'class.g.dart';

@Schemed(generateSchema: false, title: 'class')
@IdAdder()
@IndexValidator()
abstract class ClassDefinition extends ProtocolFileDefinitionWithFields {
  @PropertyName('class')
  @ClassNameValidator('class')
  @override
  String get name;

  @PropertyName('table')
  String? get tableName;

  @DocumentationExtractorConverter()
  @override
  Map<FieldName, FieldDefinition> get fields;

  Map<IndexName, IndexDefinition>? get indexes;

  @Ignored()
  @override
  bool get isException => false;

  static ClassDefinition? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) =>
      _ClassDefinition.fromYaml(yaml, context, collector);

  @override
  ClassDefinition applyProtocolReferencesToFieldTypes(
      List<ProtocolFileDefinition> definitions) {
    return _ClassDefinition._(
      fileName,
      subDirectory,
      serverOnly,
      documentation,
      name,
      tableName,
      fields.map((key, value) => MapEntry(
            key,
            value.applyProtocolReferencesToFieldTypes(definitions),
          )),
      indexes,
    );
  }
}

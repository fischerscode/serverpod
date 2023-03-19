import 'package:schemed_annotation/schemed_annotation.dart';

import '../../util/yaml_docs.dart';
import 'fields.dart';
import 'files.dart';

part 'exception.g.dart';

@Schemed(generateSchema: false, title: 'exception')
abstract class ExceptionDefinition extends ProtocolFileDefinitionWithFields {
  @PropertyName('exception')
  @ClassNameValidator('exception')
  @override
  String get name;

  @Ignored()
  @override
  bool get isException => true;

  static ExceptionDefinition? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) =>
      _ExceptionDefinition.fromYaml(yaml, context, collector);

  @override
  ExceptionDefinition applyProtocolReferencesToFieldTypes(
      List<ProtocolFileDefinition> definitions) {
    return _ExceptionDefinition._(
      fileName,
      subDirectory,
      serverOnly,
      documentation,
      fields.map((key, value) => MapEntry(
            key,
            value.applyProtocolReferencesToFieldTypes(definitions),
          )),
      name,
    );
  }
}

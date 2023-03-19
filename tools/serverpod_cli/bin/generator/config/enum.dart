import 'package:schemed_annotation/schemed_annotation.dart';

import '../../util/string_validators.dart';
import '../../util/yaml_docs.dart';
import 'files.dart';

part 'enum.g.dart';

@Schemed(generateSchema: false, title: 'enum')
abstract class EnumDefinition extends ProtocolFileDefinition {
  @PropertyName('enum')
  @ClassNameValidator('enum')
  @override
  String get name;

  @DocumentationExtractorConverter()
  List<EnumValueDefinition> get values;

  static EnumDefinition? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) =>
      _EnumDefinition.fromYaml(yaml, context, collector);
}

@Schemed(generateSchema: false, title: 'enum value')
@CustomSchema({'type': 'string'})
abstract class EnumValueDefinition {
  @NodeValueFromParent()
  @EnumValuesValidator()
  String get name;

  @NodeValueFromParent()
  @DocumentationCreator(getDocsForEnumValue: true)
  List<String>? get documentation;

  static EnumValueDefinition? fromYaml(
    YamlNode yaml,
    YamlDocumentationExtractor docsExtractor, [
    ErrorCollector? collector,
  ]) =>
      _EnumValueDefinition.fromYaml(yaml, docsExtractor, collector);
}

class EnumValuesValidator extends Validator {
  const EnumValuesValidator();

  @override
  bool validate(YamlNode node, [ErrorCollector? collector]) {
    if (!StringValidators.isValidFieldName(node.value.toString())) {
      collector.addWarning(
          SchemedWarning('Enum values should be lowerCamelCase.', node.span));
    }
    return true;
  }
}

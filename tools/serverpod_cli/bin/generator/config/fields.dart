import 'package:schemed_annotation/schemed_annotation.dart';

import '../../util/string_validators.dart';
import '../../util/yaml_docs.dart';
import '../class_generator_dart.dart';
import '../types.dart';
import 'class.dart';
import 'exception.dart';
import 'files.dart';

part 'fields.g.dart';

@Schemed(
    subTypes: [ClassDefinition, ExceptionDefinition],
    generateSchema: false,
    title: 'protocol file with fields',
    description: 'class or exception')
abstract class ProtocolFileDefinitionWithFields extends ProtocolFileDefinition {
  @DocumentationExtractorConverter()
  Map<FieldName, FieldDefinition> get fields;

  @Ignored()
  bool get isException;

  static ProtocolFileDefinitionWithFields? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) =>
      _ProtocolFileDefinitionWithFields.fromYaml(yaml, context, collector);

  ProtocolFileDefinitionWithFields applyProtocolReferencesToFieldTypes(
      List<ProtocolFileDefinition> definitions);
}

@Schemed(generateSchema: false, title: 'field name')
@CustomSchema({'type': 'string'})
abstract class FieldName {
  @NodeValueFromParent()
  @FieldNameValidator('key')
  String get name;

  @NodeValueFromParent()
  @DocumentationCreator()
  List<String>? get documentation;

  static FieldName? fromYaml(
    YamlNode yaml,
    YamlDocumentationExtractor docsExtractor, [
    ErrorCollector? collector,
  ]) =>
      _FieldName.fromYaml(yaml, docsExtractor, collector);

  @Ignored()
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    return (other is FieldName && name == other.name) ||
        (other is String && name == other);
  }
}

@Schemed(
    generateSchema: false,
    title: 'field description',
    subTypes: [InLineFieldDefinition])
abstract class FieldDefinition {
  TypeDefinition get type;

  FieldScope get scope;
  String? get parentTable;

  static FieldDefinition? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) =>
      _FieldDefinition.fromYaml(yaml, collector);

  bool shouldIncludeField(bool serverCode) {
    if (serverCode) return true;
    if (scope == FieldScope.all || scope == FieldScope.api) return true;
    return false;
  }

  bool shouldSerializeField(bool serverCode) {
    if (scope == FieldScope.all || scope == FieldScope.api) return true;
    return false;
  }

  bool shouldSerializeFieldForDatabase(bool serverCode) {
    assert(serverCode);
    if (scope == FieldScope.all || scope == FieldScope.database) return true;
    return false;
  }

  FieldDefinition applyProtocolReferencesToFieldTypes(
      List<ProtocolFileDefinition> definitions);
}

@CustomSchema({'type': 'string'})
class InLineFieldDefinition extends FieldDefinition {
  @Ignored()
  @override
  final TypeDefinition type;

  @Ignored()
  @override
  final FieldScope scope;

  @Ignored()
  @override
  final String? parentTable;

  @NodeValueFromParent()
  String get description => '';

  InLineFieldDefinition({
    required this.type,
    required this.scope,
    this.parentTable,
  });

  static InLineFieldDefinition? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) {
    try {
      var fieldDescription = yaml.value;

      if (fieldDescription is! String) {
        collector.addError(UnexpectedTypeException('String', yaml.span));
        return null;
      }

      fieldDescription = fieldDescription.replaceAll(' ', '');

      var typeResult = parseAndAnalyzeType(
        fieldDescription,
        sourceSpan: yaml.span,
      );

      var fieldOptions =
          fieldDescription.substring(typeResult.parsedPosition).split(',');

      if (fieldOptions
              .where((option) => option == 'database' || option == 'api')
              .length >
          1) {
        collector.addError(SchemedException(
          'The field scope (database or api) must at most be set once.',
          yaml.span,
        ));
        return null;
      }
      var scope = fieldOptions.any((option) => option == 'database')
          ? FieldScope.database
          : fieldOptions.any((option) => option == 'api')
              ? FieldScope.api
              : FieldScope.all;

      if (fieldOptions.where((option) => option.startsWith('parent')).length >
          1) {
        collector.addError(SchemedException(
          'Only one parent must be set.',
          yaml.span,
        ));
        return null;
      }

      var parentTable = fieldOptions
          .whereType<String?>()
          .firstWhere(
            (option) => option?.startsWith('parent=') ?? false,
            orElse: () => null,
          )
          ?.substring(7);

      if (parentTable != null &&
          !StringValidators.isValidTableIndexName(parentTable)) {
        collector.addError(SchemedException(
          '$parentTable is no valid parent name.',
          yaml.span,
        ));
        return null;
      }

      var isEnum =
          fieldOptions.whereType<String?>().any((option) => option == 'enum');

      return InLineFieldDefinition(
        scope: scope,
        type: typeResult.type..isEnum = isEnum,
        parentTable: parentTable,
      );
    } catch (e) {
      collector.addError(SchemedException(
        'Field description is invalid.',
        yaml.span,
      ));
      return null;
    }
  }

  @override
  InLineFieldDefinition applyProtocolReferencesToFieldTypes(
      List<ProtocolFileDefinition> definitions) {
    return InLineFieldDefinition(
      scope: scope,
      type: type
          .applyProtocolReferences(definitions)
          .maybeMarkAsEnum(definitions),
      parentTable: parentTable,
    );
  }
}

class FieldNameValidator extends Validator {
  final String propertyName;

  const FieldNameValidator(this.propertyName);

  @override
  bool validate(YamlNode node, [ErrorCollector? collector]) {
    if (!StringValidators.isValidFieldName(node.value.toString())) {
      collector.addWarning(SchemedWarning(
          'The $propertyName should be a valid Dart variable names (e.g. camelCaseString).',
          node.span));
    }
    return true;
  }
}

//TODO: This is a bit of a hack.
class IdAdder extends PostCreationValidator<ClassDefinition> {
  const IdAdder();
  @override
  bool validate(ClassDefinition value, YamlNode node,
      [ErrorCollector? collector]) {
    if (value.tableName != null) {
      var fields = value.fields.entries.toList();
      value.fields.clear();
      value.fields[_FieldName._('id', [
        '/// The database id, set if the object has been inserted into the',
        '/// database or if it has been fetched from the database. Otherwise,',
        '/// the id will be null.',
      ])] = InLineFieldDefinition(
        type: TypeDefinition.int.asNullable,
        scope: FieldScope.all,
      );
      value.fields.addEntries(fields);
    }
    return true;
  }
}

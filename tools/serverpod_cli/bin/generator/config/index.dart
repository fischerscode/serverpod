import 'package:schemed_annotation/schemed_annotation.dart';

import '../../util/string_validators.dart';
import '../class_generator_dart.dart';
import 'class.dart';

part 'index.g.dart';

@Schemed(generateSchema: false, title: 'index name')
@CustomSchema({'type': 'string'})
abstract class IndexName {
  @NodeValueFromParent()
  @TableIndexNameValidator('index')
  String get name;

  static IndexName? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) =>
      _IndexName.fromYaml(yaml, collector);

  @Ignored()
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    return (other is IndexName && name == other.name) ||
        (other is String && name == other);
  }
}

@Schemed(generateSchema: false, title: 'index definition')
abstract class IndexDefinition {
  //TODO: Maybe a list would be nicer then a String
  @CustomSchema({'type': 'string'})
  @IndexFieldsCreator()
  List<String> get fields;

  //TODO: Enum with valid options
  @Default('btree')
  String get type => 'btree';

  @Default(false)
  bool get unique => false;

  static IndexDefinition? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) =>
      _IndexDefinition.fromYaml(yaml, collector);
}

class IndexFieldsCreator extends CustomPropertyCreator<List<String>, void> {
  const IndexFieldsCreator();

  @override
  List<String>? fromYaml(YamlNode? node, YamlNode parent, void context,
      [ErrorCollector? collector]) {
    var fieldsStr = node?.value;

    if (fieldsStr is! String) {
      collector.addError(SchemedException(
        'The "fields" property must be of type String.',
        (node ?? parent).span,
      ));
      return null;
    }

    var fieldNames =
        fieldsStr.split(',').map((String str) => str.trim()).toList();
    //TODO: Can this even happen?
    if (fieldNames.isEmpty) {
      collector.addError(SchemedException(
        'At least on field must be set.',
        (node ?? parent).span,
      ));
      return null;
    }
    return fieldNames;
  }
}

class TableIndexNameValidator extends Validator {
  final String propertyName;

  const TableIndexNameValidator(this.propertyName);

  @override
  bool validate(YamlNode node, [ErrorCollector? collector]) {
    if (!StringValidators.isValidTableIndexName(node.value.toString())) {
      collector.addWarning(SchemedWarning(
          'The "$propertyName" property should be a in lower_snake_case.',
          node.span));
    }
    return true;
  }
}

/// Validates that all fields used in the indexes are defined.
class IndexValidator extends PostCreationValidator<ClassDefinition> {
  const IndexValidator();
  @override
  bool validate(ClassDefinition value, YamlNode node,
      [ErrorCollector? collector]) {
    bool result = true;

    var validDatabaseFieldNames = value.fields.entries
        .where((field) => field.value.scope != FieldScope.api)
        .map((e) => e.key.name)
        .toSet();

    for (var index in (value.indexes?.entries ??
        <MapEntry<IndexName, IndexDefinition>>[])) {
      for (var field in index.value.fields) {
        if (!validDatabaseFieldNames.contains(field)) {
          collector.addError(SchemedException(
            'The field name "${index.key.name}" is not added to the class or has an api scope.',
            ((node as YamlMap).nodes['indexes'] as YamlMap)
                .nodes[index.key.name]!
                .span,
          ));
          result = false;
        }
      }
    }
    return result;
  }
}

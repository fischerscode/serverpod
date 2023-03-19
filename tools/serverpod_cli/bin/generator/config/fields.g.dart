// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// SchemedGenerator
// **************************************************************************

abstract class _ProtocolFileDefinitionWithFields
    extends ProtocolFileDefinitionWithFields {
  static ProtocolFileDefinitionWithFields? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) {
    var testFromYaml =
        [ClassDefinition.fromYaml, ExceptionDefinition.fromYaml].map((e) {
      var collector = BufferingErrorCollector();
      return MapEntry(e(yaml, context, collector), collector);
    }).toList();

    return testFromYaml.withMinErrors(collector);
  }
}

class _FieldName extends FieldName {
  _FieldName._(
    this.name,
    this.documentation,
  );

  @override
  final String name;

  @override
  final List<String>? documentation;

  static _FieldName? fromYaml(
    YamlNode yaml,
    YamlDocumentationExtractor context, [
    ErrorCollector? collector,
  ]) {
    if (yaml != null &&
        !const FieldNameValidator('key').validate(yaml!, collector)) {
      return null;
    }
    var name = (YamlNode? node) {
      if (node == null) {
        return null;
      }
      if (node.value is! String) {
        collector.addError(UnexpectedTypeException("String", node.span));
        return null;
      } else {
        return node.value as String?;
      }
    }(yaml);

    var documentation =
        const DocumentationCreator().fromYaml(yaml, yaml, context, collector);

    if (name == null) {
      return null;
    } else {
      var instance = _FieldName._(name, documentation);

      return instance;
    }
  }
}

abstract class _FieldDefinition extends FieldDefinition {
  static FieldDefinition? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) {
    var testFromYaml = [InLineFieldDefinition.fromYaml].map((e) {
      var collector = BufferingErrorCollector();
      return MapEntry(e(yaml, collector), collector);
    }).toList();

    return testFromYaml.withMinErrors(collector);
  }
}

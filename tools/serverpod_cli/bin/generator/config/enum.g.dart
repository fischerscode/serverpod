// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// SchemedGenerator
// **************************************************************************

class _EnumDefinition extends EnumDefinition {
  _EnumDefinition._(
    this.fileName,
    this.subDirectory,
    bool? serverOnly,
    this.documentation,
    this.name,
    this.values,
  ) : _serverOnly = serverOnly;

  @override
  final String fileName;

  @override
  final String? subDirectory;

  final bool? _serverOnly;

  @override
  final List<String>? documentation;

  @override
  final String name;

  @override
  final List<EnumValueDefinition> values;

  static _EnumDefinition? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) {
    if (yaml is! YamlMap) {
      collector.addError(UnexpectedTypeException("Object", yaml.span));
      return null;
    }

    Schemed.checkUnknownKeys(
        yaml,
        ['fileName', 'subDirectory', 'serverOnly', 'enum', 'values'],
        collector);

    if (!Schemed.checkMissingKeys(yaml, ['enum', 'values'], collector)) {
      return null;
    }

    var fileName = const FileNamePropertyCreator()
        .fromYaml(yaml.nodes['fileName'], yaml, context, collector);

    var subDirectory = const SubdirectoryPropertyCreator()
        .fromYaml(yaml.nodes['subDirectory'], yaml, context, collector);

    var serverOnly = (YamlNode? node) {
      if (node == null) {
        return null;
      }
      if (node.value is! bool) {
        collector.addError(UnexpectedTypeException("boolean", node.span));
        return null;
      } else {
        return node.value as bool?;
      }
    }(yaml.nodes['serverOnly']);

    var documentation = const DocumentationCreator().fromYaml(
        yaml,
        yaml,
        const DocumentationExtractorConverter()
            .convert(context, yaml, yaml, collector),
        collector);

    if (yaml.nodes['enum'] != null &&
        !const ClassNameValidator('enum')
            .validate(yaml.nodes['enum']!, collector)) {
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
    }(yaml.nodes['enum']);

    var values = (YamlNode? node, YamlDocumentationExtractor context) {
      var list = (YamlNode? node) {
        if (node == null) {
          return null;
        }
        if (node.value is! YamlList) {
          collector.addError(UnexpectedTypeException("Array", node.span));
          return null;
        } else {
          return node.value as YamlList?;
        }
      }(node);

      if (list != null) {
        return list.nodes
            .map((e) => (YamlNode? node, YamlDocumentationExtractor context) {
                  if (node == null) {
                    return null;
                  }
                  return EnumValueDefinition.fromYaml(node, context, collector);
                }(e, context))
            .whereType<EnumValueDefinition>()
            .toList();
      } else {
        return null;
      }
    }(
        yaml.nodes['values'],
        const DocumentationExtractorConverter()
            .convert(context, yaml.nodes['values'], yaml, collector));

    if (fileName == null || name == null || values == null) {
      return null;
    } else {
      var instance = _EnumDefinition._(
          fileName, subDirectory, serverOnly, documentation, name, values);

      return instance;
    }
  }

  @override
  bool get serverOnly {
    return _serverOnly ?? (super.serverOnly);
  }
}

class _EnumValueDefinition extends EnumValueDefinition {
  _EnumValueDefinition._(
    this.name,
    this.documentation,
  );

  @override
  final String name;

  @override
  final List<String>? documentation;

  static _EnumValueDefinition? fromYaml(
    YamlNode yaml,
    YamlDocumentationExtractor context, [
    ErrorCollector? collector,
  ]) {
    if (yaml != null &&
        !const EnumValuesValidator().validate(yaml!, collector)) {
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

    var documentation = const DocumentationCreator(getDocsForEnumValue: true)
        .fromYaml(yaml, yaml, context, collector);

    if (name == null) {
      return null;
    } else {
      var instance = _EnumValueDefinition._(name, documentation);

      return instance;
    }
  }
}

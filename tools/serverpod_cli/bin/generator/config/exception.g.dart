// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception.dart';

// **************************************************************************
// SchemedGenerator
// **************************************************************************

class _ExceptionDefinition extends ExceptionDefinition {
  _ExceptionDefinition._(
    this.fileName,
    this.subDirectory,
    bool? serverOnly,
    this.documentation,
    this.fields,
    this.name,
  ) : _serverOnly = serverOnly;

  @override
  final String fileName;

  @override
  final String? subDirectory;

  final bool? _serverOnly;

  @override
  final List<String>? documentation;

  @override
  final Map<FieldName, FieldDefinition> fields;

  @override
  final String name;

  static _ExceptionDefinition? fromYaml(
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
        ['fileName', 'subDirectory', 'serverOnly', 'fields', 'exception'],
        collector);

    if (!Schemed.checkMissingKeys(yaml, ['fields', 'exception'], collector)) {
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

    var fields = (YamlNode? node, YamlDocumentationExtractor context) {
      var map = (YamlNode? node) {
        if (node == null) {
          return null;
        }
        if (node.value is! YamlMap) {
          collector.addError(UnexpectedTypeException("Object", node.span));
          return null;
        } else {
          return node.value as YamlMap?;
        }
      }(node);

      if (map != null) {
        return (map.nodes.map((k, v) => MapEntry(
                (YamlNode? node, YamlDocumentationExtractor context) {
                  if (node == null) {
                    return null;
                  }
                  return FieldName.fromYaml(node, context, collector);
                }(k, context),
                (YamlNode? node) {
                  if (node == null) {
                    return null;
                  }
                  return FieldDefinition.fromYaml(node, collector);
                }(v)))
              ..removeWhere((k, v) => k == null || v == null))
            .cast<FieldName, FieldDefinition>();
      } else {
        return null;
      }
    }(
        yaml.nodes['fields'],
        const DocumentationExtractorConverter()
            .convert(context, yaml.nodes['fields'], yaml, collector));

    if (yaml.nodes['exception'] != null &&
        !const ClassNameValidator('exception')
            .validate(yaml.nodes['exception']!, collector)) {
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
    }(yaml.nodes['exception']);

    if (fileName == null || fields == null || name == null) {
      return null;
    } else {
      var instance = _ExceptionDefinition._(
          fileName, subDirectory, serverOnly, documentation, fields, name);

      return instance;
    }
  }

  @override
  bool get serverOnly {
    return _serverOnly ?? (super.serverOnly);
  }
}

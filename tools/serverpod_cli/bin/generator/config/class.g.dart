// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// SchemedGenerator
// **************************************************************************

class _ClassDefinition extends ClassDefinition {
  _ClassDefinition._(
    this.fileName,
    this.subDirectory,
    bool? serverOnly,
    this.documentation,
    this.name,
    this.tableName,
    this.fields,
    this.indexes,
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
  final String? tableName;

  @override
  final Map<FieldName, FieldDefinition> fields;

  @override
  final Map<IndexName, IndexDefinition>? indexes;

  static _ClassDefinition? fromYaml(
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
        [
          'fileName',
          'subDirectory',
          'serverOnly',
          'class',
          'table',
          'fields',
          'indexes'
        ],
        collector);

    if (!Schemed.checkMissingKeys(yaml, ['class', 'fields'], collector)) {
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

    if (yaml.nodes['class'] != null &&
        !const ClassNameValidator('class')
            .validate(yaml.nodes['class']!, collector)) {
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
    }(yaml.nodes['class']);

    var tableName = (YamlNode? node) {
      if (node == null) {
        return null;
      }
      if (node.value != null && node.value is! String) {
        collector.addError(UnexpectedTypeException("String", node.span));
        return null;
      } else {
        return node.value as String?;
      }
    }(yaml.nodes['table']);

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

    var indexes = (YamlNode? node) {
      var map = (YamlNode? node) {
        if (node == null) {
          return null;
        }
        if (node.value != null && node.value is! YamlMap) {
          collector.addError(UnexpectedTypeException("Object", node.span));
          return null;
        } else {
          return node.value as YamlMap?;
        }
      }(node);

      if (map != null) {
        return (map.nodes.map((k, v) => MapEntry(
                (YamlNode? node) {
                  if (node == null) {
                    return null;
                  }
                  return IndexName.fromYaml(node, collector);
                }(k),
                (YamlNode? node) {
                  if (node == null) {
                    return null;
                  }
                  return IndexDefinition.fromYaml(node, collector);
                }(v)))
              ..removeWhere((k, v) => k == null || v == null))
            .cast<IndexName, IndexDefinition>();
      } else {
        return null;
      }
    }(yaml.nodes['indexes']);

    if (fileName == null || name == null || fields == null) {
      return null;
    } else {
      var instance = _ClassDefinition._(fileName, subDirectory, serverOnly,
          documentation, name, tableName, fields, indexes);

      if (!const IdAdder().validate(instance, yaml, collector)) {
        return null;
      }

      if (!const IndexValidator().validate(instance, yaml, collector)) {
        return null;
      }

      return instance;
    }
  }

  @override
  bool get serverOnly {
    return _serverOnly ?? (super.serverOnly);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// SchemedGenerator
// **************************************************************************

class _IndexName extends IndexName {
  _IndexName._(this.name);

  @override
  final String name;

  static _IndexName? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) {
    if (yaml != null &&
        !const TableIndexNameValidator('index').validate(yaml!, collector)) {
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

    if (name == null) {
      return null;
    } else {
      var instance = _IndexName._(name);

      return instance;
    }
  }
}

class _IndexDefinition extends IndexDefinition {
  _IndexDefinition._(
    this.fields,
    String? type,
    bool? unique,
  )   : _type = type,
        _unique = unique;

  @override
  final List<String> fields;

  final String? _type;

  final bool? _unique;

  static _IndexDefinition? fromYaml(
    YamlNode yaml, [
    ErrorCollector? collector,
  ]) {
    if (yaml is! YamlMap) {
      collector.addError(UnexpectedTypeException("Object", yaml.span));
      return null;
    }

    Schemed.checkUnknownKeys(yaml, ['fields', 'type', 'unique'], collector);

    if (!Schemed.checkMissingKeys(yaml, [], collector)) {
      return null;
    }

    var fields = const IndexFieldsCreator()
        .fromYaml(yaml.nodes['fields'], yaml, null, collector);

    var type = (YamlNode? node) {
      if (node == null) {
        return null;
      }
      if (node.value is! String) {
        collector.addError(UnexpectedTypeException("String", node.span));
        return null;
      } else {
        return node.value as String?;
      }
    }(yaml.nodes['type']);

    var unique = (YamlNode? node) {
      if (node == null) {
        return null;
      }
      if (node.value is! bool) {
        collector.addError(UnexpectedTypeException("boolean", node.span));
        return null;
      } else {
        return node.value as bool?;
      }
    }(yaml.nodes['unique']);

    if (fields == null) {
      return null;
    } else {
      var instance = _IndexDefinition._(fields, type, unique);

      return instance;
    }
  }

  @override
  String get type {
    return _type ?? (super.type);
  }

  @override
  bool get unique {
    return _unique ?? (super.unique);
  }
}

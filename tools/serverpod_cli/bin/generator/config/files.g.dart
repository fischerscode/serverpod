// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// SchemedGenerator
// **************************************************************************

abstract class _ProtocolFileDefinition extends ProtocolFileDefinition {
  static ProtocolFileDefinition? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) {
    var testFromYaml = [
      ProtocolFileDefinitionWithFields.fromYaml,
      EnumDefinition.fromYaml
    ].map((e) {
      var collector = BufferingErrorCollector();
      return MapEntry(e(yaml, context, collector), collector);
    }).toList();

    return testFromYaml.withMinErrors(collector);
  }
}

import 'package:schemed_annotation/schemed_annotation.dart';
import 'package:source_span/source_span.dart';
import 'package:path/path.dart' as p;

import '../../util/string_validators.dart';
import '../../util/yaml_docs.dart';
import '../../util/extensions.dart';
import 'enum.dart';
import 'fields.dart';

part 'files.g.dart';

@Schemed(
    subTypes: [ProtocolFileDefinitionWithFields, EnumDefinition],
    title: 'Protocol file definition')
abstract class ProtocolFileDefinition {
  @FileNamePropertyCreator()
  @ExcludeFromSchema()
  String get fileName;

  String get name;

  @SubdirectoryPropertyCreator()
  @ExcludeFromSchema()
  String? get subDirectory;

  @Default(false)
  bool get serverOnly => false;

  @DocumentationExtractorConverter()
  @DocumentationCreator()
  @NodeValueFromParent()
  List<String>? get documentation;

  static ProtocolFileDefinition? fromYaml(
    YamlNode yaml,
    ProtocolFileContext context, [
    ErrorCollector? collector,
  ]) =>
      _ProtocolFileDefinition.fromYaml(yaml, context, collector);

  /// Generate the file reference [String] to this file.
  String fileRef() {
    return p.posix
        // ignore: prefer_interpolation_to_compose_strings
        .joinAll(p.split('${(subDirectory + '/') ?? ''}$fileName.dart'));
  }
}

class ProtocolFileContext {
  final YamlDocumentationExtractor docsExtractor;
  final String? subDirectory;
  final String fileName;

  const ProtocolFileContext({
    required this.docsExtractor,
    required this.subDirectory,
    required this.fileName,
  });
}

class DocumentationExtractorConverter
    extends ContextConverter<ProtocolFileContext, YamlDocumentationExtractor> {
  const DocumentationExtractorConverter();
  @override
  YamlDocumentationExtractor convert(
      ProtocolFileContext context, YamlNode? node, YamlNode parent,
      [ErrorCollector? collector]) {
    return context.docsExtractor;
  }
}

class SubdirectoryPropertyCreator
    extends CustomPropertyCreator<String?, ProtocolFileContext> {
  const SubdirectoryPropertyCreator();
  @override
  String? fromYaml(YamlNode? node, YamlNode parent, ProtocolFileContext context,
      [ErrorCollector? collector]) {
    return context.subDirectory;
  }
}

class FileNamePropertyCreator
    extends CustomPropertyCreator<String?, ProtocolFileContext> {
  const FileNamePropertyCreator();
  @override
  String? fromYaml(YamlNode? node, YamlNode parent, ProtocolFileContext context,
      [ErrorCollector? collector]) {
    return context.fileName;
  }
}

class ClassNameValidator extends Validator {
  final String propertyName;

  const ClassNameValidator(this.propertyName);

  @override
  bool validate(YamlNode node, [ErrorCollector? collector]) {
    if (!StringValidators.isValidClassName(node.value.toString())) {
      collector.addWarning(SchemedWarning(
          'The "$propertyName" property should be a valid class name (e.g. CamelCaseString).',
          node.span));
    }
    return true;
  }
}

class TableNameValidator extends Validator {
  final String propertyName;

  const TableNameValidator(this.propertyName);

  @override
  bool validate(YamlNode node, [ErrorCollector? collector]) {
    if (!StringValidators.isValidTableName(node.value.toString())) {
      collector.addWarning(SchemedWarning(
          'The "$propertyName" property should be a lower_snake_case.',
          node.span));
    }
    return true;
  }
}

class DocumentationCreator
    extends CustomPropertyCreator<List<String>?, YamlDocumentationExtractor> {
  const DocumentationCreator({this.getDocsForEnumValue = false});

  final bool getDocsForEnumValue;

  @override
  List<String>? fromYaml(
    YamlNode? node,
    YamlNode parent,
    YamlDocumentationExtractor docsExtractor, [
    ErrorCollector? collector,
  ]) {
    assert(node != null);
    if (node == null) {
      return null;
    }
    if (getDocsForEnumValue) {
      return docsExtractor.getDocumentation(
        SourceLocation(node.span.start.offset - 2,
            column: node.span.start.column - 2,
            line: node.span.start.line,
            sourceUrl: node.span.start.sourceUrl),
      );
    } else {
      return docsExtractor.getDocumentation(node.span.start);
    }
  }
}

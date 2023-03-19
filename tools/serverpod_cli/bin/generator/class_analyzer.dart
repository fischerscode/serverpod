import 'dart:io';

import 'package:source_span/source_span.dart';
import 'package:yaml/src/error_listener.dart';
import 'package:yaml/yaml.dart';
import '../util/subdirectory_extraction.dart';
import '../util/yaml_docs.dart';
import 'code_analysis_collector.dart';
import 'config.dart';
import 'config/fields.dart';
import 'config/files.dart';
import 'package:schemed_annotation/schemed_annotation.dart' as schemed;

List<ProtocolFileDefinition> performAnalyzeClasses({
  bool verbose = true,
  required CodeAnalysisCollector collector,
}) {
  var classDefinitions = <ProtocolFileDefinition>[];

  // Get list of all files in protocol source directory.
  var sourceDir = Directory(config.protocolSourcePath);
  var sourceFileList = sourceDir.listSync(recursive: true);
  sourceFileList.sort((a, b) => a.path.compareTo(b.path));

  for (var entity in sourceFileList) {
    if (entity is! File || !entity.path.endsWith('.yaml')) {
      if (verbose) print('  - skipping file: ${entity.path}');
      continue;
    }
    String? subDirectory = extractSubdirectoryFromRelativePath(
        entity.path, config.protocolSourcePath);

    // Process a file.
    if (verbose) print('  - processing file: ${entity.path}');
    var yaml = entity.readAsStringSync();
    var analyzer = ClassAnalyzer(
      yaml: yaml,
      sourceFileName: entity.path,
      outFileName: _transformFileNameWithoutPathOrExtension(entity.path),
      collector: collector,
      subDirectory: subDirectory,
    );
    var classDefinition = analyzer.analyze();
    if (classDefinition != null) {
      classDefinitions.add(classDefinition);
    }
  }

  //Detect protocol references and Detect enum fields
  classDefinitions = classDefinitions.map((d) {
    if (d is ProtocolFileDefinitionWithFields) {
      return d.applyProtocolReferencesToFieldTypes(classDefinitions);
    } else {
      return d;
    }
  }).toList();

  return classDefinitions;
}

String _transformFileNameWithoutPathOrExtension(String path) {
  var pathComponents = path.split(Platform.pathSeparator);
  var fileName = pathComponents.last;
  fileName = fileName.substring(0, fileName.length - 5);
  return fileName;
}

class ClassAnalyzer {
  final String yaml;
  final String sourceFileName;
  final String outFileName;
  final String? subDirectory;
  final CodeAnalysisCollector collector;

  ClassAnalyzer({
    required this.yaml,
    required this.sourceFileName,
    required this.outFileName,
    this.subDirectory,
    required this.collector,
  });

  ProtocolFileDefinition? analyze() {
    var yamlErrorCollector = ErrorCollector();
    var schemedCollector = _SchemedErrorCollector(collector);

    YamlDocument document;
    try {
      document = loadYamlDocument(
        yaml,
        sourceUrl: Uri.file(sourceFileName),
        errorListener: yamlErrorCollector,
      );
    } catch (e) {
      if (e is SourceSpanException) {
        collector.addError(e);
        return null;
      }
      rethrow;
    }

    collector.addErrors(yamlErrorCollector.errors);

    if (yamlErrorCollector.errors.isNotEmpty) {
      return null;
    }

    var documentContents = document.contents;

    // Validate document is a map.
    if (documentContents is! YamlMap) {
      collector.addError(SourceSpanException(
        'The top level object in the class yaml file must be a Map.',
        documentContents.span,
      ));
      return null;
    }
    var docsExtractor = YamlDocumentationExtractor(yaml);

    return ProtocolFileDefinition.fromYaml(
        documentContents,
        ProtocolFileContext(
            docsExtractor: docsExtractor,
            subDirectory: subDirectory,
            fileName: outFileName),
        schemedCollector);
  }
}

class _SchemedErrorCollector extends schemed.ErrorCollector {
  final CodeAnalysisCollector errorCollector;

  _SchemedErrorCollector(this.errorCollector);
  @override
  void addError(schemed.SchemedException error) {
    errorCollector
        .addError(SourceSpanFormatException(error.message, error.span));
  }

  @override
  void addWarning(schemed.SchemedWarning warning) {
    errorCollector
        .addError(SourceSpanFormatException(warning.message, warning.span));
  }
}

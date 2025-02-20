import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:serverpod_serialization/serverpod_serialization.dart';

import 'endpoint.dart';
import 'server.dart';
import 'serverpod.dart';
import 'session.dart';

/// The [EndpointDispatch] is responsible for directing requests to the [Server]
/// to the correct [Endpoint] and method. Typically, this class is overridden
/// by an Endpoints class that is generated.
abstract class EndpointDispatch {
  /// All connectors associating endpoint method names with the actual methods.
  Map<String, EndpointConnector> connectors = {};

  /// References to modules.
  Map<String, EndpointDispatch> modules = {};

  /// Initializes all endpoints that are connected to the dispatch.
  void initializeEndpoints(Server server);

  /// Registers any modules with the dispatch.
  void registerModules(Serverpod pod);

  /// Finds an [EndpointConnector] by its name. If the connector is in a module,
  /// a period should separate the module name from the endpoint name.
  EndpointConnector? getConnectorByName(String endpointName) {
    var endpointComponents = endpointName.split('.');
    if (endpointComponents.isEmpty || endpointComponents.length > 2) {
      return null;
    }

    // Find correct connector
    EndpointConnector? connector;

    if (endpointComponents.length == 1) {
      // This is a standard server endpoint
      connector = connectors[endpointName];
      if (connector == null) return null;
    } else {
      // Connector is in a module
      var modulePackage = endpointComponents[0];
      endpointName = endpointComponents[1];
      var module = modules[modulePackage];
      if (module == null) return null;

      connector = module.connectors[endpointName];
      if (connector == null) return null;
    }

    return connector;
  }

  /// Dispatches a call to the [Server] to the correct [Endpoint] method. If
  /// successful, it returns the object from the method. If unsuccessful it will
  /// return a [Result] object.
  Future<Result> handleUriCall(Server server, String endpointName, Uri uri,
      String body, HttpRequest request) async {
    var endpointComponents = endpointName.split('.');
    if (endpointComponents.isEmpty || endpointComponents.length > 2) {
      return ResultInvalidParams(
          'Endpoint $endpointName is not a valid endpoint name');
    }

    // Find correct connector
    var connector = getConnectorByName(endpointName);
    if (connector == null) {
      return ResultInvalidParams('Endpoint $endpointName does not exist');
    }

    MethodCallSession session;

    try {
      session = MethodCallSession(
        server: server,
        uri: uri,
        body: body,
        endpointName: endpointName,
        httpRequest: request,
        enableLogging: connector.endpoint.logSessions,
      );
    } catch (e) {
      return ResultInvalidParams('Malformed call: $uri');
    }

    var methodName = session.methodName;
    var inputParams = session.queryParameters;

    try {
      var authFailed = await canUserAccessEndpoint(session, connector.endpoint);
      if (authFailed != null) {
        return authFailed;
      }

      var method = connector.methodConnectors[methodName];
      if (method == null) {
        await session.close();
        return ResultInvalidParams(
            'Method $methodName not found in call: $uri');
      }

      // TODO: Check parameters and check null safety

      var paramMap = <String, dynamic>{};
      for (var paramName in inputParams.keys) {
        var type = method.params[paramName]?.type;
        if (type == null) continue;
        var formatted = _formatArg(
            inputParams[paramName], type, server.serializationManager);
        paramMap[paramName] = formatted;
      }

      var result = await method.call(session, paramMap);

      // Print session info
      // var authenticatedUserId = connector.endpoint.requireLogin ? await session.auth.authenticatedUserId : null;

      await session.close();

      return ResultSuccess(
        result,
        sendByteDataAsRaw: connector.endpoint.sendByteDataAsRaw,
      );
    } catch (e, stackTrace) {
      // Something did not work out
      var sessionLogId = await session.close(error: e, stackTrace: stackTrace);
      return ResultInternalServerError(
          e.toString(), stackTrace, sessionLogId ?? 0);
    }
  }

  /// Checks if a user can access an [Endpoint]. If access is granted null is
  /// returned, otherwise a [ResultAuthenticationFailed] describing the issue is
  /// returned.
  Future<ResultAuthenticationFailed?> canUserAccessEndpoint(
      Session session, Endpoint endpoint) async {
    var auth = session.authenticationKey;
    if (endpoint.requireLogin) {
      if (auth == null) {
        return ResultAuthenticationFailed('No authentication provided');
      }
      if (!await session.isUserSignedIn) {
        return ResultAuthenticationFailed('Authentication failed');
      }
    }

    if (endpoint.requiredScopes.isNotEmpty) {
      if (!await session.isUserSignedIn) {
        return ResultAuthenticationFailed(
            'Sign in required to access this endpoint');
      }

      for (var requiredScope in endpoint.requiredScopes) {
        if (!(await session.scopes)!.contains(requiredScope)) {
          return ResultAuthenticationFailed(
              'User does not have access to scope ${requiredScope.name}');
        }
      }
    }
    return null;
  }

  Object? _formatArg(
      String? input, Type type, SerializationManager serializationManager) {
    // Check for basic types.
    if (type == String) return input;
    if (type == int) return int.tryParse(input!);
    if (type == double) return double.tryParse(input!);
    if (type == bool) {
      if (input == 'true') {
        return true;
      } else if (input == 'false') {
        return false;
      }
      return null;
    }
    if (type == DateTime) return DateTime.tryParse(input!);
    if (type == ByteData) return input?.base64DecodedByteData();

    // List types.
    if (type == List<int>) {
      return (jsonDecode(input!) as List).cast<int>();
    }
    if (type == List<int?>) {
      return (jsonDecode(input!) as List).cast<int?>();
    }
    if (type == List<double>) {
      return (jsonDecode(input!) as List).cast<double>();
    }
    if (type == List<double?>) {
      return (jsonDecode(input!) as List).cast<double?>();
    }
    if (type == List<bool>) {
      return (jsonDecode(input!) as List).cast<bool>();
    }
    if (type == List<bool?>) {
      return (jsonDecode(input!) as List).cast<bool?>();
    }
    if (type == List<String>) {
      return (jsonDecode(input!) as List).cast<String>();
    }
    if (type == List<String?>) {
      return (jsonDecode(input!) as List).cast<String?>();
    }
    if (type == List<DateTime>) {
      var stringList = (jsonDecode(input!) as List).cast<String>();
      return stringList
          .map((e) => DateTime.tryParse(e)!)
          .toList()
          .cast<DateTime>();
    }
    if (type == List<DateTime?>) {
      var stringList = (jsonDecode(input!) as List).cast<String?>();
      return stringList
          .map((e) => e == null ? null : DateTime.tryParse(e)!)
          .toList()
          .cast<DateTime?>();
    }
    if (type == List<ByteData>) {
      var stringList = (jsonDecode(input!) as List).cast<String>();
      return stringList
          .map((e) => e.base64DecodedByteData()!)
          .toList()
          .cast<ByteData>();
    }
    if (type == List<ByteData?>) {
      var stringList = (jsonDecode(input!) as List).cast<String?>();
      return stringList
          .map((e) => e?.base64DecodedByteData())
          .toList()
          .cast<ByteData?>();
    }
    if (type.toString().startsWith('List<')) {
      var stringList = (jsonDecode(input!) as List).cast<String?>();
      return stringList
          .map((e) => e == null
              ? null
              : serializationManager
                  .createEntityFromSerialization(jsonDecode(e)))
          .toList();
    }

    // Map types.
    if (type == Map<String, int>) {
      return (jsonDecode(input!) as Map).cast<String, int>();
    }
    if (type == Map<String, int?>) {
      return (jsonDecode(input!) as Map).cast<String, int?>();
    }
    if (type == Map<String, double>) {
      return (jsonDecode(input!) as Map).cast<String, double>();
    }
    if (type == Map<String, double?>) {
      return (jsonDecode(input!) as Map).cast<String, double?>();
    }
    if (type == Map<String, bool>) {
      return (jsonDecode(input!) as Map).cast<String, bool>();
    }
    if (type == Map<String, bool?>) {
      return (jsonDecode(input!) as Map).cast<String, bool?>();
    }
    if (type == Map<String, String>) {
      return (jsonDecode(input!) as Map).cast<String, String>();
    }
    if (type == Map<String, String?>) {
      return (jsonDecode(input!) as Map).cast<String, String?>();
    }
    if (type == Map<String, DateTime>) {
      var stringMap = (jsonDecode(input!) as Map).cast<String, String>();
      return stringMap
          .map((k, v) => MapEntry(k, DateTime.tryParse(v)!))
          .cast<String, DateTime>();
    }
    if (type == Map<String, DateTime?>) {
      var stringMap = (jsonDecode(input!) as Map).cast<String, String?>();
      return stringMap
          .map((k, v) => MapEntry(k, v == null ? null : DateTime.tryParse(v)!))
          .cast<String, DateTime?>();
    }
    if (type == Map<String, ByteData>) {
      var stringMap = (jsonDecode(input!) as Map).cast<String, String>();
      return stringMap
          .map((k, v) => MapEntry(k, v.base64DecodedByteData()!))
          .cast<String, ByteData>();
    }
    if (type == Map<String, ByteData?>) {
      var stringMap = (jsonDecode(input!) as Map).cast<String, String?>();
      return stringMap
          .map((k, v) => MapEntry(k, v?.base64DecodedByteData()))
          .cast<String, ByteData?>();
    }
    if (type.toString().startsWith('Map<')) {
      var stringMap = (jsonDecode(input!) as Map).cast<String, String?>();
      return stringMap.map(
        (k, v) => MapEntry(
          k,
          v == null
              ? null
              : serializationManager
                  .createEntityFromSerialization(jsonDecode(v)),
        ),
      );
    }

    // Serialized objects.
    try {
      var data = jsonDecode(input!);
      return serializationManager.createEntityFromSerialization(data);
    } catch (error) {
      return null;
    }
  }
}

/// The [EndpointConnector] associates a name with and endpoint and its
/// [MethodConnector]s.
class EndpointConnector {
  /// Name of the [Endpoint].
  final String name;

  /// Reference to the [Endpoint].
  final Endpoint endpoint;

  /// All [MethodConnector]s associated with the [Endpoint].
  final Map<String, MethodConnector> methodConnectors;

  /// Creates a new [EndpointConnector].
  EndpointConnector(
      {required this.name,
      required this.endpoint,
      required this.methodConnectors});
}

/// Calls a named method referenced in a [MethodConnector].
typedef MethodCall = Future Function(
    Session session, Map<String, dynamic> params);

/// The [MethodConnector] hooks up a method with its name and the actual call
/// to the method.
class MethodConnector {
  /// The name of the method.
  final String name;

  /// List of parameters used by the method.
  final Map<String, ParameterDescription> params;

  /// A function that performs a call to the named method.
  final MethodCall call;

  /// Creates a new [MethodConnector].
  MethodConnector(
      {required this.name, required this.params, required this.call});
}

/// Defines a parameter in a [MethodConnector].
class ParameterDescription {
  /// The name of the parameter.
  final String name;

  /// The Dart type of the parameter.
  final Type type;

  /// True if the parameter can be nullable.
  final bool nullable;

  /// Creates a new [ParameterDescription].
  ParameterDescription(
      {required this.name, required this.type, required this.nullable});
}

/// The [Result] of an [Endpoint] method call.
abstract class Result {}

/// A successful result from an [Endpoint] method call containing the return
/// value of the call.
class ResultSuccess extends Result {
  /// The returned value of a successful [Endpoint] method call.
  final dynamic returnValue;

  /// True if [ByteData] should not be embedded in API serialization.
  final bool sendByteDataAsRaw;

  /// Creates a new successful result with a value.
  ResultSuccess(this.returnValue, {this.sendByteDataAsRaw = false});
}

/// The result of a failed [Endpoint] method call where the parameters where not
/// valid.
class ResultInvalidParams extends Result {
  /// Description of the error.
  final String errorDescription;

  /// Creates a new [ResutInvalidParams] object.
  ResultInvalidParams(this.errorDescription);

  @override
  String toString() {
    return errorDescription;
  }
}

/// The result of a failed [Endpoint] method call where authentication failed.
class ResultAuthenticationFailed extends Result {
  /// Description of the error.
  final String errorDescription;

  /// Creates a new [ResultAuthenticationFailed] object.
  ResultAuthenticationFailed(this.errorDescription);

  @override
  String toString() {
    return errorDescription;
  }
}

/// The result of a failed [Endpoint] method call where an [Exception] was
/// thrown during execution of the method.
class ResultInternalServerError extends Result {
  /// The Exception that was thrown.
  final String exception;

  /// Stack trace when the exception occurred.
  final StackTrace stackTrace;

  /// The session log id.
  final int? sessionLogId;

  /// Creates a new [ResultInternalServerError].
  ResultInternalServerError(this.exception, this.stackTrace, this.sessionLogId);

  @override
  String toString() {
    return '$exception\n$stackTrace';
  }
}

/// The result of a failed [Endpoint] method call, with a custom status code.
class ResultStatusCode extends Result {
  /// The status code to be returned to the client.
  final int statusCode;

  /// Creates a new [ResultStatusCode].
  ResultStatusCode(this.statusCode);

  @override
  String toString() {
    return 'Status Code: $statusCode';
  }
}

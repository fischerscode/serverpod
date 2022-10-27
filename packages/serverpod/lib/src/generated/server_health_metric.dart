/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class ServerHealthMetric extends _i1.TableRow {
  ServerHealthMetric({
    int? id,
    required this.name,
    required this.serverId,
    required this.timestamp,
    required this.isHealthy,
    required this.value,
  }) : super(id);

  factory ServerHealthMetric.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ServerHealthMetric(
      id: serializationManager.deserializeJson<int?>(jsonSerialization['id']),
      name: serializationManager
          .deserializeJson<String>(jsonSerialization['name']),
      serverId: serializationManager
          .deserializeJson<String>(jsonSerialization['serverId']),
      timestamp: serializationManager
          .deserializeJson<DateTime>(jsonSerialization['timestamp']),
      isHealthy: serializationManager
          .deserializeJson<bool>(jsonSerialization['isHealthy']),
      value: serializationManager
          .deserializeJson<double>(jsonSerialization['value']),
    );
  }

  static final t = ServerHealthMetricTable();

  String name;

  String serverId;

  DateTime timestamp;

  bool isHealthy;

  double value;

  @override
  String get tableName => 'serverpod_health_metric';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'serverId': serverId,
      'timestamp': timestamp,
      'isHealthy': isHealthy,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'name': name,
      'serverId': serverId,
      'timestamp': timestamp,
      'isHealthy': isHealthy,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'name': name,
      'serverId': serverId,
      'timestamp': timestamp,
      'isHealthy': isHealthy,
      'value': value,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'name':
        name = value;
        return;
      case 'serverId':
        serverId = value;
        return;
      case 'timestamp':
        timestamp = value;
        return;
      case 'isHealthy':
        isHealthy = value;
        return;
      case 'value':
        value = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<ServerHealthMetric>> find(
    _i1.Session session, {
    ServerHealthMetricExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ServerHealthMetric>(
      where: where != null ? where(ServerHealthMetric.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<ServerHealthMetric?> findSingleRow(
    _i1.Session session, {
    ServerHealthMetricExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<ServerHealthMetric>(
      where: where != null ? where(ServerHealthMetric.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<ServerHealthMetric?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<ServerHealthMetric>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required ServerHealthMetricExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ServerHealthMetric>(
      where: where(ServerHealthMetric.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    ServerHealthMetric row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    ServerHealthMetric row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    ServerHealthMetric row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    ServerHealthMetricExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ServerHealthMetric>(
      where: where != null ? where(ServerHealthMetric.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef ServerHealthMetricExpressionBuilder = _i1.Expression Function(
    ServerHealthMetricTable);

class ServerHealthMetricTable extends _i1.Table {
  ServerHealthMetricTable() : super(tableName: 'serverpod_health_metric');

  final id = _i1.ColumnInt('id');

  final name = _i1.ColumnString('name');

  final serverId = _i1.ColumnString('serverId');

  final timestamp = _i1.ColumnDateTime('timestamp');

  final isHealthy = _i1.ColumnBool('isHealthy');

  final value = _i1.ColumnDouble('value');

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        serverId,
        timestamp,
        isHealthy,
        value,
      ];
}

@Deprecated('Use ServerHealthMetricTable.t instead.')
ServerHealthMetricTable tServerHealthMetric = ServerHealthMetricTable();

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i2;
import 'protocol.dart' as _i3;

class ObjectWithEnum extends _i1.TableRow {
  ObjectWithEnum({
    int? id,
    required this.testEnum,
    this.nullableEnum,
    required this.enumList,
    required this.nullableEnumList,
  }) : super(id);

  factory ObjectWithEnum.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i2.SerializationManager serializationManager,
  ) {
    return ObjectWithEnum(
      id: serializationManager.deserializeJson<int?>(jsonSerialization['id']),
      testEnum: serializationManager
          .deserializeJson<_i3.TestEnum>(jsonSerialization['testEnum']),
      nullableEnum: serializationManager
          .deserializeJson<_i3.TestEnum?>(jsonSerialization['nullableEnum']),
      enumList: serializationManager
          .deserializeJson<List<_i3.TestEnum>>(jsonSerialization['enumList']),
      nullableEnumList:
          serializationManager.deserializeJson<List<_i3.TestEnum?>>(
              jsonSerialization['nullableEnumList']),
    );
  }

  static final t = ObjectWithEnumTable();

  _i3.TestEnum testEnum;

  _i3.TestEnum? nullableEnum;

  List<_i3.TestEnum> enumList;

  List<_i3.TestEnum?> nullableEnumList;

  @override
  String get className => 'ObjectWithEnum';
  @override
  String get tableName => 'object_with_enum';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testEnum': testEnum,
      'nullableEnum': nullableEnum,
      'enumList': enumList,
      'nullableEnumList': nullableEnumList,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'testEnum': testEnum,
      'nullableEnum': nullableEnum,
      'enumList': enumList,
      'nullableEnumList': nullableEnumList,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'testEnum': testEnum,
      'nullableEnum': nullableEnum,
      'enumList': enumList,
      'nullableEnumList': nullableEnumList,
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
      case 'testEnum':
        testEnum = value;
        return;
      case 'nullableEnum':
        nullableEnum = value;
        return;
      case 'enumList':
        enumList = value;
        return;
      case 'nullableEnumList':
        nullableEnumList = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<ObjectWithEnum>> find(
    _i1.Session session, {
    ObjectWithEnumExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ObjectWithEnum>(
      where: where != null ? where(ObjectWithEnum.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<ObjectWithEnum?> findSingleRow(
    _i1.Session session, {
    ObjectWithEnumExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<ObjectWithEnum>(
      where: where != null ? where(ObjectWithEnum.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<ObjectWithEnum?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<ObjectWithEnum>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required ObjectWithEnumExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ObjectWithEnum>(
      where: where(ObjectWithEnum.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    ObjectWithEnum row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    ObjectWithEnum row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    ObjectWithEnum row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    ObjectWithEnumExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ObjectWithEnum>(
      where: where != null ? where(ObjectWithEnum.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef ObjectWithEnumExpressionBuilder = _i1.Expression Function(
    ObjectWithEnumTable);

class ObjectWithEnumTable extends _i1.Table {
  ObjectWithEnumTable() : super(tableName: 'object_with_enum');

  final id = _i1.ColumnInt('id');

  final testEnum = _i1.ColumnSerializable('testEnum');

  final nullableEnum = _i1.ColumnSerializable('nullableEnum');

  final enumList = _i1.ColumnSerializable('enumList');

  final nullableEnumList = _i1.ColumnSerializable('nullableEnumList');

  @override
  List<_i1.Column> get columns => [
        id,
        testEnum,
        nullableEnum,
        enumList,
        nullableEnumList,
      ];
}

@Deprecated('Use ObjectWithEnumTable.t instead.')
ObjectWithEnumTable tObjectWithEnum = ObjectWithEnumTable();

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i2;

class UserInfo extends _i1.TableRow {
  UserInfo({
    int? id,
    required this.userIdentifier,
    required this.userName,
    this.fullName,
    this.email,
    required this.created,
    this.imageUrl,
    required this.scopeNames,
    required this.active,
    required this.blocked,
    this.suspendedUntil,
  }) : super(id);

  factory UserInfo.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i2.SerializationManager serializationManager,
  ) {
    return UserInfo(
      id: serializationManager.deserializeJson<int?>(jsonSerialization['id']),
      userIdentifier: serializationManager
          .deserializeJson<String>(jsonSerialization['userIdentifier']),
      userName: serializationManager
          .deserializeJson<String>(jsonSerialization['userName']),
      fullName: serializationManager
          .deserializeJson<String?>(jsonSerialization['fullName']),
      email: serializationManager
          .deserializeJson<String?>(jsonSerialization['email']),
      created: serializationManager
          .deserializeJson<DateTime>(jsonSerialization['created']),
      imageUrl: serializationManager
          .deserializeJson<String?>(jsonSerialization['imageUrl']),
      scopeNames: serializationManager
          .deserializeJson<List<String>>(jsonSerialization['scopeNames']),
      active: serializationManager
          .deserializeJson<bool>(jsonSerialization['active']),
      blocked: serializationManager
          .deserializeJson<bool>(jsonSerialization['blocked']),
      suspendedUntil: serializationManager
          .deserializeJson<DateTime?>(jsonSerialization['suspendedUntil']),
    );
  }

  static final t = UserInfoTable();

  String userIdentifier;

  String userName;

  String? fullName;

  String? email;

  DateTime created;

  String? imageUrl;

  List<String> scopeNames;

  bool active;

  bool blocked;

  DateTime? suspendedUntil;

  @override
  String get className => 'serverpod_auth_server.UserInfo';
  @override
  String get tableName => 'serverpod_user_info';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userIdentifier': userIdentifier,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'created': created,
      'imageUrl': imageUrl,
      'scopeNames': scopeNames,
      'active': active,
      'blocked': blocked,
      'suspendedUntil': suspendedUntil,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'userIdentifier': userIdentifier,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'created': created,
      'imageUrl': imageUrl,
      'scopeNames': scopeNames,
      'active': active,
      'blocked': blocked,
      'suspendedUntil': suspendedUntil,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'userIdentifier': userIdentifier,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'created': created,
      'imageUrl': imageUrl,
      'scopeNames': scopeNames,
      'active': active,
      'blocked': blocked,
      'suspendedUntil': suspendedUntil,
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
      case 'userIdentifier':
        userIdentifier = value;
        return;
      case 'userName':
        userName = value;
        return;
      case 'fullName':
        fullName = value;
        return;
      case 'email':
        email = value;
        return;
      case 'created':
        created = value;
        return;
      case 'imageUrl':
        imageUrl = value;
        return;
      case 'scopeNames':
        scopeNames = value;
        return;
      case 'active':
        active = value;
        return;
      case 'blocked':
        blocked = value;
        return;
      case 'suspendedUntil':
        suspendedUntil = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<UserInfo>> find(
    _i1.Session session, {
    UserInfoExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserInfo>(
      where: where != null ? where(UserInfo.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<UserInfo?> findSingleRow(
    _i1.Session session, {
    UserInfoExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<UserInfo>(
      where: where != null ? where(UserInfo.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<UserInfo?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<UserInfo>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required UserInfoExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserInfo>(
      where: where(UserInfo.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    UserInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    UserInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    UserInfo row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    UserInfoExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserInfo>(
      where: where != null ? where(UserInfo.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef UserInfoExpressionBuilder = _i1.Expression Function(UserInfoTable);

class UserInfoTable extends _i1.Table {
  UserInfoTable() : super(tableName: 'serverpod_user_info');

  final id = _i1.ColumnInt('id');

  final userIdentifier = _i1.ColumnString('userIdentifier');

  final userName = _i1.ColumnString('userName');

  final fullName = _i1.ColumnString('fullName');

  final email = _i1.ColumnString('email');

  final created = _i1.ColumnDateTime('created');

  final imageUrl = _i1.ColumnString('imageUrl');

  final scopeNames = _i1.ColumnSerializable('scopeNames');

  final active = _i1.ColumnBool('active');

  final blocked = _i1.ColumnBool('blocked');

  final suspendedUntil = _i1.ColumnDateTime('suspendedUntil');

  @override
  List<_i1.Column> get columns => [
        id,
        userIdentifier,
        userName,
        fullName,
        email,
        created,
        imageUrl,
        scopeNames,
        active,
        blocked,
        suspendedUntil,
      ];
}

@Deprecated('Use UserInfoTable.t instead.')
UserInfoTable tUserInfo = UserInfoTable();

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;
import 'protocol.dart' as _i2;

class SimpleDataList extends _i1.SerializableEntity {
  SimpleDataList({required this.rows});

  factory SimpleDataList.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return SimpleDataList(
        rows: serializationManager
            .deserializeJson<List<_i2.SimpleData>>(jsonSerialization['rows']));
  }

  List<_i2.SimpleData> rows;

  @override
  String get className => 'SimpleDataList';
  @override
  Map<String, dynamic> toJson() {
    return {'rows': rows};
  }
}

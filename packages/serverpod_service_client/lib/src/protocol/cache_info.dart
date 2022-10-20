/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

class CacheInfo extends _i1.SerializableEntity {
  CacheInfo({
    required this.numEntries,
    required this.maxEntries,
    this.keys,
  });

  factory CacheInfo.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return CacheInfo(
      numEntries: serializationManager
          .deserializeJson<int>(jsonSerialization['numEntries']),
      maxEntries: serializationManager
          .deserializeJson<int>(jsonSerialization['maxEntries']),
      keys: serializationManager
          .deserializeJson<List<String>?>(jsonSerialization['keys']),
    );
  }

  int numEntries;

  int maxEntries;

  List<String>? keys;

  @override
  String get className => 'CacheInfo';
  @override
  Map<String, dynamic> toJson() {
    return {
      'numEntries': numEntries,
      'maxEntries': maxEntries,
      'keys': keys,
    };
  }
}

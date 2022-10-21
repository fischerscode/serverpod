/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class UserSettingsConfig extends _i1.SerializableEntity {
  UserSettingsConfig({
    required this.canSeeUserName,
    required this.canSeeFullName,
    required this.canEditUserName,
    required this.canEditFullName,
    required this.canEditUserImage,
  });

  factory UserSettingsConfig.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return UserSettingsConfig(
      canSeeUserName: serializationManager
          .deserializeJson<bool>(jsonSerialization['canSeeUserName']),
      canSeeFullName: serializationManager
          .deserializeJson<bool>(jsonSerialization['canSeeFullName']),
      canEditUserName: serializationManager
          .deserializeJson<bool>(jsonSerialization['canEditUserName']),
      canEditFullName: serializationManager
          .deserializeJson<bool>(jsonSerialization['canEditFullName']),
      canEditUserImage: serializationManager
          .deserializeJson<bool>(jsonSerialization['canEditUserImage']),
    );
  }

  bool canSeeUserName;

  bool canSeeFullName;

  bool canEditUserName;

  bool canEditFullName;

  bool canEditUserImage;

  @override
  String get className => 'serverpod_auth_server.UserSettingsConfig';
  @override
  Map<String, dynamic> toJson() {
    return {
      'canSeeUserName': canSeeUserName,
      'canSeeFullName': canSeeFullName,
      'canEditUserName': canEditUserName,
      'canEditFullName': canEditFullName,
      'canEditUserImage': canEditUserImage,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'canSeeUserName': canSeeUserName,
      'canSeeFullName': canSeeFullName,
      'canEditUserName': canEditUserName,
      'canEditFullName': canEditFullName,
      'canEditUserImage': canEditUserImage,
    };
  }
}

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

class ChatJoinChannelFailed extends _i1.SerializableEntity {
  ChatJoinChannelFailed({
    required this.channel,
    required this.reason,
  });

  factory ChatJoinChannelFailed.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatJoinChannelFailed(
      channel: serializationManager
          .deserializeJson<String>(jsonSerialization['channel']),
      reason: serializationManager
          .deserializeJson<String>(jsonSerialization['reason']),
    );
  }

  String channel;

  String reason;

  @override
  String get className => 'serverpod_chat_server.ChatJoinChannelFailed';
  @override
  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'reason': reason,
    };
  }
}

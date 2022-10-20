/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

class ChatRequestMessageChunk extends _i1.SerializableEntity {
  ChatRequestMessageChunk({
    required this.channel,
    required this.lastMessageId,
  });

  factory ChatRequestMessageChunk.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatRequestMessageChunk(
      channel: serializationManager
          .deserializeJson<String>(jsonSerialization['channel']),
      lastMessageId: serializationManager
          .deserializeJson<int>(jsonSerialization['lastMessageId']),
    );
  }

  String channel;

  int lastMessageId;

  @override
  String get className => 'serverpod_chat_server.ChatRequestMessageChunk';
  @override
  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'lastMessageId': lastMessageId,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'channel': channel,
      'lastMessageId': lastMessageId,
    };
  }
}

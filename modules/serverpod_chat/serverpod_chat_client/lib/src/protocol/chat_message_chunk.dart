/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;
import 'protocol.dart' as _i2;

class ChatMessageChunk extends _i1.SerializableEntity {
  ChatMessageChunk({
    required this.channel,
    required this.messages,
    required this.hasOlderMessages,
  });

  factory ChatMessageChunk.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ChatMessageChunk(
      channel: serializationManager
          .deserializeJson<String>(jsonSerialization['channel']),
      messages: serializationManager.deserializeJson<List<_i2.ChatMessage>>(
          jsonSerialization['messages']),
      hasOlderMessages: serializationManager
          .deserializeJson<bool>(jsonSerialization['hasOlderMessages']),
    );
  }

  String channel;

  List<_i2.ChatMessage> messages;

  bool hasOlderMessages;

  @override
  String get className => 'serverpod_chat_server.ChatMessageChunk';
  @override
  Map<String, dynamic> toJson() {
    return {
      'channel': channel,
      'messages': messages,
      'hasOlderMessages': hasOlderMessages,
    };
  }
}

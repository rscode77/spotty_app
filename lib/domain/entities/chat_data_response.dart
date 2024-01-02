import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_data_response.freezed.dart';
part 'chat_data_response.g.dart';

@freezed
class ChatDataResponse with _$ChatDataResponse {
  const factory ChatDataResponse({
    required String lastMessage,
    required String toUserId,
    required DateTime messageTime,
    required bool isRead,
  }) = _ChatDataResponse;

  factory ChatDataResponse.fromJson(Map<String, dynamic> json) => _$ChatDataResponseFromJson(json);

  static List<ChatDataResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ChatDataResponse.fromJson(item)).toList();
  }
}
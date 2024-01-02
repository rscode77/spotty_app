import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_chats_response.freezed.dart';
part 'user_chats_response.g.dart';

@freezed
class UserChatsResponse with _$UserChatsResponse {
  const factory UserChatsResponse({
    required String chatId,
    required String lastMessage,
    required DateTime timestamp,
  }) = _UserChatsResponse;

  factory UserChatsResponse.fromJson(Map<String, dynamic> json) => _$UserChatsResponseFromJson(json);

  static List<UserChatsResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => UserChatsResponse.fromJson(item)).toList();
  }
}


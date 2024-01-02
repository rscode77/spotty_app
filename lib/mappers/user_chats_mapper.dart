import 'package:spotty_app/data/models/user_chat_data_model.dart';
import 'package:spotty_app/domain/entities/user_chats_response.dart';

extension UserChatsMapper on UserChatsResponse {
  UserChats mapToUserChats() {
    return UserChats(
      chatId: chatId,
      lastMessage: lastMessage,
      timestamp: timestamp,
    );
  }
}

extension UserChatsListMapper on List<UserChatsResponse> {
  List<UserChats> mapToUserChatsList() {
    return map((userChatsResponse) => userChatsResponse.mapToUserChats()).toList();
  }
}
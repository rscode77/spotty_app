import 'package:spotty_app/data/models/chat_data_model.dart';
import 'package:spotty_app/domain/entities/chat_data_response.dart';

extension ChatDataMapper on ChatDataResponse {
  ChatData mapToChatData() {
    return ChatData(
      lastMessage: lastMessage,
      toUserId: toUserId,
      messageTime: messageTime,
      isRead: isRead,
    );
  }
}

extension ChatDataListMapper on List<ChatDataResponse> {
  List<ChatData> mapToChatDataList() {
    return map((eventApiResponse) => eventApiResponse.mapToChatData()).toList();
  }
}
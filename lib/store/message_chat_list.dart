import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simplechatfiverr/store/message_info.dart';
import 'package:mobx/mobx.dart';

part 'message_chat_list.g.dart';

class MessageChatList = _MessageChatList with _$MessageChatList;

abstract class _MessageChatList with Store {
  @observable
  var messageBubbles = ObservableList<MessageInfo>();

  @action
  void refreshMessageList(
      List<DocumentSnapshot> messages, dynamic currentUser) {
    messageBubbles.clear();

    for (DocumentSnapshot message in messages.reversed) {
      print(message.data);
      messageBubbles
          .add(MessageInfo(message.data['sender'], message.data['text']));
    }
  }
}

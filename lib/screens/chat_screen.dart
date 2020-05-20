import 'package:simplechatfiverr/services/auth_service.dart';
import 'package:simplechatfiverr/store/message_chat_list.dart';
import 'package:flutter/material.dart';
import 'package:simplechatfiverr/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simplechatfiverr/components/bubble_mex.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final _firestore = Firestore.instance;

class ChatScreen extends StatelessWidget {
  final messageTextController = TextEditingController();
  final MessageChatList messageChatList = MessageChatList();

  void messagesStreams() async {
    await for (var snapshot
        in _firestore.collection('messages').orderBy("timestamp").snapshots()) {
      messageChatList.refreshMessageList(snapshot.documents, currentUser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    String messageText;

    messagesStreams();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              signOutGoogle();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Observer(
                builder: (context) => ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: messageChatList.messageBubbles.length,
                  itemBuilder: (_, index) => MessageBubble(
                    sender: messageChatList.messageBubbles[index].sender,
                    text: messageChatList.messageBubbles[index].text,
                    isMe: currentUser.email ==
                        messageChatList.messageBubbles[index].sender,
                  ),
                ),
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (messageText != null) {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': currentUser.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                      }
                      messageText = null;
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

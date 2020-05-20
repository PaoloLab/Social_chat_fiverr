// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_chat_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageChatList on _MessageChatList, Store {
  final _$messageBubblesAtom = Atom(name: '_MessageChatList.messageBubbles');

  @override
  ObservableList<MessageInfo> get messageBubbles {
    _$messageBubblesAtom.reportRead();
    return super.messageBubbles;
  }

  @override
  set messageBubbles(ObservableList<MessageInfo> value) {
    _$messageBubblesAtom.reportWrite(value, super.messageBubbles, () {
      super.messageBubbles = value;
    });
  }

  final _$_MessageChatListActionController =
      ActionController(name: '_MessageChatList');

  @override
  void refreshMessageList(
      List<DocumentSnapshot> messages, dynamic currentUser) {
    final _$actionInfo = _$_MessageChatListActionController.startAction(
        name: '_MessageChatList.refreshMessageList');
    try {
      return super.refreshMessageList(messages, currentUser);
    } finally {
      _$_MessageChatListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageBubbles: ${messageBubbles}
    ''';
  }
}

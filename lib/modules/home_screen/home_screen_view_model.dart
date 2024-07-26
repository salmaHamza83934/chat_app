import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/room.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/connector/connector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenViewModel extends ChangeNotifier {
  late Connector connector;
  late MyUser myUser;
  late Room room;
  late Stream<QuerySnapshot<Message>> streamMessage;

  void addRoom(String roomTitle, String roomDescription,
      String categoryId) async {
    Room room = Room(
        roomId: '',
        title: roomTitle,
        description: roomDescription,
        categoryId: categoryId);
    connector.showLoading();
    try {
      connector.hideLoading();
      connector.showMessage('room added successfully.');
      await DatabaseUtils.addRoomToFireStore(room);
    } catch (e) {
      connector.hideLoading();
      connector.showMessage(e.toString());
      print(e.toString());
    }
  }

  void sendMessage(String content) async{
    Message message = Message(roomId: room.roomId,
        content: content,
        senderId: myUser.id,
        senderName: myUser.userName,
        dateTime: DateTime.now().millisecondsSinceEpoch);
    print(DateTime.now().millisecondsSinceEpoch);
    try{
      var res= await DatabaseUtils.insertMessage(message);
    }catch(e){
      connector.showMessage(e.toString());
    }
  }

  void listenForUpdateMessages(){
    streamMessage=DatabaseUtils.getMessagesFromFireStore(room.roomId);
  }
}

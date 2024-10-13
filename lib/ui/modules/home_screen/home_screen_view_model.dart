import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/database/database_utils.dart';
import '../../../data/models/message.dart';
import '../../../data/models/room.dart';
import '../../../data/models/user_model.dart';
import '../connector/connector.dart';

class HomeScreenViewModel extends ChangeNotifier {
  TextEditingController roomNameController = TextEditingController();

  TextEditingController roomDescriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
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

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
import '../models/room.dart';
import '../models/user_model.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
      toFirestore: (user, options) => user.toJson());
  }
  static Future<void> registerUser(MyUser user) async{
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String userId)async {
    var documentSnapshot=await getUserCollection().doc(userId).get();
    return documentSnapshot.data();
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance.collection(Room.collectionName)
        .withConverter(
        fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
        toFirestore: (room, options) => room.toJson());
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance.collection(Room.collectionName).doc(roomId).collection(Message.collectionName)
        .withConverter<Message>(
        fromFirestore: (snapshot, options) => Message.fromJson(snapshot.data()!),
        toFirestore: (message, options) => message.toJson());
  }

  static Future<void> addRoomToFireStore(Room room) async{
   var docRef= getRoomsCollection().doc();
    room.roomId=docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRooms(){
    print(getRoomsCollection().snapshots().length);
    return getRoomsCollection().snapshots();

  }

  static Future<void> insertMessage(Message message) async{
    var messageCollection=getMessageCollection(message.roomId);
    var docRef=messageCollection.doc();
    message.id=docRef.id;
    return docRef.set(message);
  }
  static Stream<QuerySnapshot<Message>> getMessagesFromFireStore(String roomId){
    return getMessageCollection(roomId).orderBy('date_time',descending: false).snapshots();
  }
}
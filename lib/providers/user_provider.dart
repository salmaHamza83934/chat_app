import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  User? firebaseUser;
  MyUser? user;

  UserProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    initUser();
  }

  initUser() async{
    if(firebaseUser !=null){
      user =await DatabaseUtils.getUser(firebaseUser?.uid??'');
    }
  }
}
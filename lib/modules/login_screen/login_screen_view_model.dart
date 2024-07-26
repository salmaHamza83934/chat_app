import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/modules/connector/connector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginScreenViewModel extends ChangeNotifier{
  late Connector connector;
  void login(String email,String password) async{
    try {
      connector.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      DatabaseUtils.getUser(credential.user?.uid??'');
      connector.hideLoading();
      connector.showMessage('Login Successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        connector.hideLoading();
        connector.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        connector.hideLoading();
        connector.showMessage('wrong email or password');
        print('Wrong password provided for that user.');
      }
    }catch(e){
      connector.hideLoading();
      connector.showMessage(e.toString());
      print(e.toString());
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../data/database/database_utils.dart';
import '../connector/connector.dart';

class LoginScreenViewModel extends ChangeNotifier{

  late Connector connector;
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isVisible=false;
  void login(String email,String password) async{
    try {
      connector.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      await DatabaseUtils.getUser(credential.user?.uid??'').then((value){
        connector.hideLoading();
        connector.showMessage('Login Successfully.');
      });

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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/database/database_utils.dart';
import '../../../data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser;
  MyUser? user;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  /// Initializes the user from Firebase and the database.
  initUser() async {
    if (firebaseUser != null) {
      try {
        user = await DatabaseUtils.getUser(firebaseUser!.uid);
        notifyListeners(); // Notify listeners about user update
      } catch (error) {
        // Handle error if needed
        print("Error fetching user: $error");
      }
    }
  }

  /// Call this method to refresh the user data.
  void refreshUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    await initUser();
  }

  void clearUserData() {
    firebaseUser = null;
    user = null;
    notifyListeners(); // Notify listeners about the state change
  }
}

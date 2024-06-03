import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/view/ToDo/toDo.dart';
import 'package:plantist/view/login/login.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(auth.currentUser); //casting it to be Rx user

    _user.bindStream((auth.userChanges())); //bind our user to stream
    //whenever things changes this instance would be notified

    ever(_user,
        _initialScreen); //listener and callback function listening any changes all the time
  }

  _initialScreen(User? user) {
    if (user == null) {
      //user didnt login
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => TodoPage(
            email: user.email!,
            userId: user.uid,
          ));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Save user data to Firebase Realtime Database
      String userId = auth.currentUser!.uid;

      await _userRef.child(userId).set({
        'uid': userId,
        'email': email,
      });
    } catch (e) {
      Get.snackbar('About User', 'User Message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('Account creation failed',
              style: TextStyle(color: Colors.white)),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('About Login', 'Login Message',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText:
              const Text('Login failed', style: TextStyle(color: Colors.white)),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}

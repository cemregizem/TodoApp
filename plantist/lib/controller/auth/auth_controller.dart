import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/view/ToDo/toDo.dart';
import 'package:plantist/view/login/login.dart';

class AuthController extends GetxController {
 static AuthController instance = Get.find();
//would be able to access to our authcontroller
//and its related properties and fields from other pages
//whenever we want to access in future AuthController.instance...

late Rx<User?> _user;
//we use late because sometimes lifecycle and visibility of an object do not align.
//we use the late keyword to declare variables that will be initialized later.
FirebaseAuth auth = FirebaseAuth.instance;
//using this we ll be able to access a lot of properties from firebase

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(auth.currentUser);
    //casting it to be Rx user
    _user.bindStream((auth.userChanges())); //bind our user to stream
    //whenever things changes with the user like login or log out vs this instance would be notified

    //listener and callback function
    ever(_user, _initialScreen); //listening any changes all the time
  }

  //? for if it is null
  _initialScreen(User? user) {
    if (user == null) { //user didnt login
      print("Login Page");
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => TodoPage(email:user.email!));
    }
  }

  void register(String email, password) async {
    try {
     await auth.createUserWithEmailAndPassword(email: email, password: password);
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
          titleText: const Text('Login failed',
              style: TextStyle(color: Colors.white)),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }
  void logOut() async{
    await auth.signOut();
  }
}

// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_banner/views/homescreen.dart';

// Function to sign up a user with Firebase authentication and save data to Firestore
// ignore: non_constant_identifier_names
void SignUpUser(String userName, String userPhone, String userEmail, String userPassword) async {
  try {
    // Validate email format
    if (!GetUtils.isEmail(userEmail)) {
      print("Invalid email format");
      return;
    }

    // Create user with email and password
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    // Get the current user
    User? user = userCredential.user;

    if (user != null) {
      // Save user data to Firestore
      await FirebaseFirestore.instance.collection("users").doc().set({
        'userName': userName,
        'userPhone': userPhone,
        'userEmail': userEmail,
        'createdAt': DateTime.now(),
        'userId': user.uid,
      });

      // Sign out after user creation (optional)
      await FirebaseAuth.instance.signOut();

      // Navigate to login screen
      Get.to(() => const LoginScreen());
    }
  } on FirebaseAuthException catch (e) {
    print("Firebase authentication error: $e");
  } catch (e) {
    print("Error during signup: $e");
  }
}

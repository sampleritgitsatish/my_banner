import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
 // Make sure to import the correct path for your services

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  bool _validateEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'SignUpScreen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 220,
              child: Lottie.asset("assets/Animation - 1718905688834.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'UserName',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: userPhoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: userEmailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: userPasswordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  var userName = userNameController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPassword = userPasswordController.text.trim();

                  if (!_validateEmail(userEmail)) {
                    showSnackbar('Error', 'The email address is badly formatted.');
                    return;
                  }

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: userEmail,
                      password: userPassword,
                    );

                    // Add user data to Firebase database
                    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                      'userName': userName,
                      'userPhone': userPhone,
                      'userEmail': userEmail,
                      // Add more fields as needed
                    });

                    showSnackbar('Success', 'Account created successfully.');
                  } on FirebaseAuthException catch (e) {
                    // ignore: avoid_print
                    print("Error creating user: $e");
                    showSnackbar('Error', 'Failed to create account. Please try again.');
                  } catch (e) {
                    // ignore: avoid_print
                    print("Unexpected error: $e");
                    showSnackbar('Error', 'An unexpected error occurred. Please try again.');
                  }
                },
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.to(() => const SignedChar());
              },
              child: Card(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: const Text('Already have an account? Sign In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}

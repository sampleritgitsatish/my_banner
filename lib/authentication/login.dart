import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_banner/authentication/home.dart';
 // Import your HomeScreen widget here


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                signinWithGoogle().then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHome(), // Replace with your HomeScreen widget
                    ),
                  );
                }).catchError((error) {
                  // Handle error if sign in fails
                  print('Failed to sign in with Google: $error');
                  // Optionally show an error dialog or message
                });
              },
              child: const Text('Google Login'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signinWithGoogle() async {
  try {
    // Trigger the Google authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Print the user's display name
      print(userCredential.user?.displayName);
      print('Email: ${userCredential.user?.email}');
    } else {
      // Handle if user cancels the sign-in process
      print('Google sign in cancelled');
    }
  } catch (error) {
    // Handle other errors
    print('Error signing in with Google: $error');
    // Optionally throw or handle the error further
    throw error;
  }
}

Future<void> signOutGoogle(BuildContext context) async {
  try {
    await GoogleSignIn().signOut(); // Sign out from Google
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  } catch (error) {
    // Handle sign-out errors
    print('Error signing out: $error');
    throw error;
  }
}

// ignore: camel_case_types

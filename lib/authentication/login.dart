import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Method to handle sign-in with Google
  Future<void> _signInWithGoogle() async {
    try {
      // Trigger Google sign-in
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Get authentication details from Google
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        // Create Firebase credentials using Google's tokens
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        // Sign in with Firebase using the credentials
        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (user != null) {
          // If sign-in is successful, show user's Google authentication credentials
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Google Authentication Credentials'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Name: ${user.displayName}'),
                    Text('Email: ${user.email}'),
                    Text('Photo URL: ${user.photoURL}'),
                    Text('UID: ${user.uid}'),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle sign-in failure
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to sign in with Google.'),
            ),
          );
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add login functionality here
              },
              child: const Center(child: Text('Login')),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.black),
                label: const Text('Login with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black, // Text color
                  elevation: 3, // Shadow color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final GoogleSignIn gSignIn = GoogleSignIn();
                  try {
                    final GoogleSignInAccount? gSignInAccount = await gSignIn.signIn();
                    if (gSignInAccount != null) {
                      final GoogleSignInAuthentication gSignInAuth = await gSignInAccount.authentication;
                      final AuthCredential credential = GoogleAuthProvider.credential(
                        idToken: gSignInAuth.idToken,
                        accessToken: gSignInAuth.accessToken,
                      );
                      await _firebaseAuth.signInWithCredential(credential);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

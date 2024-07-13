import 'package:flutter/material.dart';
import 'package:my_banner/authentication/login.dart';
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

// ignore: camel_case_types
class _MyHomeState extends State<MyHome> {
  void _signOut() {
    signOutGoogle(context).then((_) {
      print('User signed out');
    }).catchError((error) {
      print('Failed to sign out: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: const Center(
        child: Text('Home screen'),
      ),
    );
  }
}

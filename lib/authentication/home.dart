import 'package:flutter/material.dart';

// ignore: camel_case_types
class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

// ignore: camel_case_types
class _myhomeState extends State<myhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: const Center(
        child:Text('Home screen'),
      )
    );
  }
}

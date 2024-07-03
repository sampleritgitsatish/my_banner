// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_banner/views/signupscreen.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _Signinscreen();
}

class _Signinscreen extends State<Signinscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Signin Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: 320,
                child: Lottie.asset("assets/Animation - 1718905688834.json"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'UserName',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.visibility_rounded),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
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
                onPressed: () {},
                child: const Text("Sign In"),
              ),
            ),
            Card(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const Signupscreen());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text('Already have an account Sign Up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

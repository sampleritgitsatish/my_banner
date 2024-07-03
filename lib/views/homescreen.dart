// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_banner/views/Forgotpassword.dart';
import 'package:my_banner/views/signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'Login Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [],
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
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
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
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.zero,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
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
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.to(()=>const Forgotpassword());
                },
                child: const Text("Forgot Password"),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                   Get.to(() => const Signupscreen());
                },
                child: const Text("Don't have an account SignUp"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() =>ForgotpasswordState();
}

class ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          'ForgotPasswordScreen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: 220,
                child: Lottie.asset("assets/Animation - 1718905688834.json"),
              ),
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
              height: 10,
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
                onPressed: () {
                  
                },
                child: const Text("Forgot Password"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          
          ],
        ),
      ),
    );
  }
}

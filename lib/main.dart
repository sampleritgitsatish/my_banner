import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_banner/authentication/first.dart'; // Assuming this is where HomePAGE is defined
import 'package:my_banner/authentication/home.dart';
import 'package:my_banner/authentication/login.dart';
import 'package:my_banner/authentication/register.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'first',
      routes: {
        'first': (context) => HomePAGE(),
        'register': (context) => Register(),
        'login': (context) => LoginScreen(),
        'home': (context) => myhome(),
      },
      title: 'Data Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.purple),
      ),
      home: const HomePAGE(),
    );
  }
}

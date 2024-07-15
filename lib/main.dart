import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_banner/authentication/home.dart';
import 'package:my_banner/services/notification_services.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationServices.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Store',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.purple),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

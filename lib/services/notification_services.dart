import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("message received! ${message.notification!.title}");
}

class NotificationServices {
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print(token);
      }
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      FirebaseMessaging.onMessage.listen((message) {
        print("message received! ${message.notification!.title}");
      });
      print('Notifications initialized!');
    }
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';

class PermissionService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> requestPermissions() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

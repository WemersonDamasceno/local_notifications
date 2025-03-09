import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class INotificationService {
  Future<void> initialize();
  Future<void> saveFcmToken();
  Future<void> showNotification(RemoteMessage message);
  Stream<Map<String, dynamic>> get onNotificationTap;
}

class NotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final FirebaseDatabase _firebaseDatabase;
  final _notificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  NotificationService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotificationsPlugin,
    FirebaseDatabase? firebaseDatabase,
  })  : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
        _localNotificationsPlugin =
            localNotificationsPlugin ?? FlutterLocalNotificationsPlugin(),
        _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  /// Stream para escutar eventos de clique nas notificações
  @override
  Stream<Map<String, dynamic>> get onNotificationTap =>
      _notificationStreamController.stream;

  @override
  Future<void> initialize() async {
    await _requestNotificationPermissions();
    await _initializeLocalNotifications();
    await _getToken();
    _setupForegroundMessageHandler();
    _setupBackgroundMessageHandler();
    _setupTerminatedMessageHandler();
  }

  Future<void> _requestNotificationPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iOSSettings = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _notificationStreamController.add(
            json.decode(response.payload!),
          );
        }
      },
    );
  }

  Future<void> _getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("Token do dispositivo: $token");
  }

  @override
  Future<void> saveFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    String? userId = 'user-wemerson';

    if (token != null) {
      DatabaseReference ref = _firebaseDatabase.ref("users/$userId");
      await ref.update({"fcmToken": token});
    }
  }

  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });
  }

  @override
  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformDetails,
      payload: jsonEncode(message.data),
    );
  }

  void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        _notificationStreamController.add(message.data);
      }
    });
  }

  Future<void> _setupTerminatedMessageHandler() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      _notificationStreamController.add(initialMessage.data);
    }
  }
}

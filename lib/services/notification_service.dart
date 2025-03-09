import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_firebase/services/path_service.dart';
import 'package:notifications_firebase/services/permission_service.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final _notificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onNotificationTap =>
      _notificationStreamController.stream;

  Future<void> initialize() async {
    await PermissionService.requestPermissions();
    await _initializeLocalNotifications();
    await _getToken();

    // Metodos que escutam os eventos
    _setupForegroundMessageHandler();
    _setupBackgroundMessageHandler();
    _setupTerminatedMessageHandler();
  }

  Future<void> _initializeLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          _notificationStreamController.add(json.decode(response.payload!));
        }
      },
    );
  }

  Future<void> _getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("Token do dispositivo: $token");
  }

  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        _showNotification(message);
      }
    });
  }

  void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _notificationStreamController.add(message.data);
    });
  }

  Future<void> _setupTerminatedMessageHandler() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      _notificationStreamController.add(initialMessage.data);
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final styleInformation = await _getImageNotification(
        imageUrl: message.notification?.android?.imageUrl);

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'fcm_notification_channel',
        'Fcm Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        category: AndroidNotificationCategory.message,
        icon: '@mipmap/ic_notification',
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: styleInformation,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotificationsPlugin.show(
      message.ttl ?? 0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  Future<BigPictureStyleInformation?> _getImageNotification({
    required String? imageUrl,
  }) async {
    if (imageUrl == null) {
      return null;
    }

    String? filePath = await PathService.downloadAndSaveFile(
      imageUrl,
      'image.jpg',
    );

    return BigPictureStyleInformation(
      filePath != null
          ? FilePathAndroidBitmap(filePath)
          : const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
  }
}

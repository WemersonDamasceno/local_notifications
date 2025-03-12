import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_firebase/services/notification_service/path_service.dart';
import 'package:notifications_firebase/services/notification_service/permission_service.dart';

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

    // if adicionado até que o token APNS esteja configurado
    // ou seja, só irá funcionar no Android por enquanto.
    if (Platform.isAndroid) {
      await _getDeviceFcmToken();
    }

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

  Future<void> _getDeviceFcmToken() async {
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
    String? imageUrl = Platform.isAndroid
        ? message.notification?.android?.imageUrl
        : message.notification?.apple?.imageUrl;

    String? filePath = await PathService.downloadAndSaveFile(
      imageUrl,
      'image.jpg',
    );

    final androidDetails = AndroidNotificationDetails(
      'fcm_notification_channel',
      'Fcm Notification Channel',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      category: AndroidNotificationCategory.message,
      icon: '@mipmap/ic_notification',
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      styleInformation: _styleInformation(filePath),
    );

    final iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      attachments: _getAttachments(filePath),
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _localNotificationsPlugin.show(
      message.ttl ?? 0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  List<DarwinNotificationAttachment>? _getAttachments(String? filePath) {
    return filePath == null
        ? null
        : [
            DarwinNotificationAttachment(
              filePath,
              identifier: 'notification_identify',
              hideThumbnail: false,
            ),
          ];
  }

  BigPictureStyleInformation _styleInformation(String? filePath) {
    return BigPictureStyleInformation(
      filePath != null
          ? FilePathAndroidBitmap(filePath)
          : const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
  }
}

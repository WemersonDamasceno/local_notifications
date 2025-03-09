import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

abstract class INotificationService {
  Future<void> initialize();
  Stream<Map<String, dynamic>> get onNotificationTap;
}

class NotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final _notificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  NotificationService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotificationsPlugin,
    FirebaseDatabase? firebaseDatabase,
  })  : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
        _localNotificationsPlugin =
            localNotificationsPlugin ?? FlutterLocalNotificationsPlugin();

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
        AndroidInitializationSettings('@mipmap/ic_notification');

    const iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(message);
      }
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final styleInformation = await _getImageNotification(
      imageUrl: message.notification?.android?.imageUrl,
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
      styleInformation: styleInformation,
    );

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
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

  Future<BigPictureStyleInformation?> _getImageNotification({
    required String? imageUrl,
  }) async {
    if (imageUrl == null) return null;
    String? filePath = await _downloadAndSaveFile(imageUrl, 'image.jpg');

    final BigPictureStyleInformation bigPictureStyle =
        BigPictureStyleInformation(
      filePath != null
          ? FilePathAndroidBitmap(filePath)
          : const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    return bigPictureStyle;
  }

  void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
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

  Future<String?> _downloadAndSaveFile(String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      print('Erro ao baixar a imagem: $e');
    }
    return null;
  }
}


//TODO: Criar uma classe PathService para salvar a imagem e retornar ela
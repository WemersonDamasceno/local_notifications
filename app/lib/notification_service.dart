import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize({required Function(String) onTap}) async {
    await _requestNotificationPermissions();
    await _initializeLocalNotifications(onTap);
    await _getToken();
    _setupForegroundMessageHandler();
    _setupBackgroundMessageHandler(onTap);
    _setupTerminatedMessageHandler(onTap);
  }

  /// Solicita permissões para exibir notificações (iOS)
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

  /// Inicializa as notificações locais
  Future<void> _initializeLocalNotifications(Function(String) onTap) async {
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
          onTap(response.payload!);
        }
      },
    );
  }

  /// Obtém o token do dispositivo para envio de notificações
  Future<void> _getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("Token do dispositivo: $token");
  }

  Future<void> saveFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    String? userId = 'user-wemerson';

    if (token != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/$userId");
      await ref.update({"fcmToken": token});
    }
  }

  /// Trata notificações recebidas **em primeiro plano** e exibe via local notification
  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });
  }

  /// Exibe a notificação usando `flutter_local_notifications`
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
      payload: message.data['score'],
    );
  }

  /// Trata notificações quando o app está **minimizado** (segundo plano)
  void _setupBackgroundMessageHandler(Function(String) onTap) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['score'] != null) {
        onTap(message.data['score']);
      }
    });
  }

  /// Trata notificações quando o app estava **fechado (terminated)**
  Future<void> _setupTerminatedMessageHandler(Function(String) onTap) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null && initialMessage.data['score'] != null) {
      onTap(initialMessage.data['score']);
    }
  }
}

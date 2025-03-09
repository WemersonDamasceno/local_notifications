import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_firebase/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initialize();

    _notificationService.onNotificationTap.listen((data) {
      _pushRoute(data['page']);
    });
  }

  void _pushRoute(String deeplink) {
    if (deeplink.isEmpty) return;

    if (deeplink.contains('/home/score_page/score')) {
      final uri = Uri.parse(deeplink);

      final String? score = uri.queryParameters['value'];

      if (score != null) {
        Navigator.pushNamed(
          context,
          '/score_page',
          arguments: score,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar - Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Home Page')),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              sendNotification();
            },
            child: const Text('Exibir notificação'),
          ),
        ],
      ),
    );
  }
}

final notificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> sendNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'score_channel',
    'Score Updates',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    visibility: NotificationVisibility.private,
    styleInformation: BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('assets/images/score.jpg'),
      contentTitle: '🔥 Novo Score!',
      summaryText: 'Seu score agora é 1000 pontos. Continue jogando! 🎮',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    ),
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  // Criando um payload em JSON
  final payload = jsonEncode({
    'page': 'app://home/score_page/score?value=435.5',
  });

  await notificationsPlugin.show(
    0,
    '🔥 Novo Score!',
    'Seu score agora é 1000 pontos. Continue jogando! 🎮',
    notificationDetails,
    payload: payload, // Agora o payload está em JSON
  );
}

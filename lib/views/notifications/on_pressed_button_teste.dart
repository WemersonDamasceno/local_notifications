import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_firebase/services/notification_service/path_service.dart';

Future<void> sendNotification(String? urlImage) async {
  int id = 0;
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  String? filePath = await PathService.downloadAndSaveFile(
    urlImage,
    'image.jpg',
  );

  final androidDetails = AndroidNotificationDetails(
    'com.example.notifications_firebase',
    'Notifications for App POC',
    importance: Importance.max,
    priority: Priority.high,
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

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iOSDetails,
  );

  final payload = jsonEncode({
    'page': 'app://home/score_page/score?value=550',
  });

  await notificationsPlugin.show(
    id,
    'Seu score mudou! 🎉',
    'Seu score mudou, veja agora mesmo seu novo score 🤩',
    notificationDetails,
    payload: payload,
  );
  id++;
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

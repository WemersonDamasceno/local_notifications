import 'dart:convert';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final notificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> sendNotification(String? urlImage) async {
  final styleInformation = await _getImageNotification(
    imageUrl: null,
  );

  final androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
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

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS: iOSDetails,
  );

  final payload = jsonEncode({
    'page': 'app://home/score_page/score?value=435.5',
  });

  await notificationsPlugin.show(
    0,
    'Seu score mudou! 🎉',
    'Seu score mudou, veja agora mesmo seu novo score 🤩',
    notificationDetails,
    payload: payload,
  );
}

Future<BigPictureStyleInformation?> _getImageNotification({
  required String? imageUrl,
}) async {
  if (imageUrl == null) return null;
  String? filePath = await _downloadAndSaveFile(imageUrl, 'image.jpg');

  final BigPictureStyleInformation bigPictureStyle = BigPictureStyleInformation(
    filePath != null
        ? FilePathAndroidBitmap(filePath)
        : const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  );

  return bigPictureStyle;
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

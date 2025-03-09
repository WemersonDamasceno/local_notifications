import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_firebase/notification_service.dart';
import 'package:notifications_firebase/score_page.dart';

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
    _notificationService.initialize(onTap: _pushRoute);
  }

  void _pushRoute(String deeplink) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ScorePage(score: deeplink);
    }));
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
              // _notificationService.showNotification(
              //   const RemoteMessage(
              //     data: {'score': '1000'},
              //     notification: RemoteNotification(
              //       title: '🔥 Novo Score!',
              //       body: 'Seu score agora é 1000 pontos. Continue jogando! 🎮',
              //       android: AndroidNotification(
              //         channelId:
              //             'score_channel', // Canal específico da notificação
              //         clickAction:
              //             'FLUTTER_NOTIFICATION_CLICK', // Para abrir o app ao clicar
              //         color: '#FF5722', // Cor da notificação (Laranja)
              //         count:
              //             3, // Número de ocorrências (ícone da notificação pode exibir um badge)
              //         imageUrl:
              //             'https://example.com/imagem.png', // URL de uma imagem para exibir na notificação

              //         priority: AndroidNotificationPriority
              //             .maximumPriority, // Prioridade alta para garantir que apareça imediatamente
              //         smallIcon:
              //             'ic_notification', // Ícone pequeno (definido nos recursos do app)
              //         sound:
              //             'notification_sound', // Som customizado (precisa estar na pasta `res/raw`)
              //         ticker:
              //             'Você tem uma nova notificação!', // Texto exibido na barra de status enquanto a notificação é recebida
              //         tag:
              //             'score_update', // Etiqueta para agrupar notificações similares
              //         visibility: AndroidNotificationVisibility
              //             .private, // Visível em qualquer contexto (público)
              //       ),
              //     ),
              //   ),
              // );
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
  // Detalhes do Android
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'score_channel', // Canal da notificação
    'Score Updates', // Nome do canal
    importance: Importance.max, // Prioridade alta
    priority: Priority.high, // Prioridade alta
    icon: '@mipmap/ic_launcher',
    visibility: NotificationVisibility.private, // Visível em qualquer contexto
    styleInformation: BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('assets/images/score.jpg'),
      contentTitle: '🔥 Novo Score!',
      summaryText: 'Seu score agora é 1000 pontos. Continue jogando! 🎮',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    ),
  );

  // Detalhes da notificação
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  // Exibindo a notificação
  await notificationsPlugin.show(
    0,
    '🔥 Novo Score!',
    'Seu score agora é 1000 pontos. Continue jogando! 🎮',
    notificationDetails,
  );
}

import 'package:flutter/material.dart';
import 'package:notifications_firebase/services/notification_service.dart';
import 'package:notifications_firebase/views/on_pressed_button_teste.dart';
import 'package:url_launcher/url_launcher.dart';

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
      _pushRouteInNotification(data['page']);
    });
  }

  void _pushRouteInNotification(String deeplink) {
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
            onPressed: () => onPressed(),
            child: const Text('Exibir notificação'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(
                    'https://serasaempreendedor.com.br/cadastro-deslogado'),
              )) {
                throw Exception('Could not launch');
              }
            },
            child: const Text('Regatar Senha'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(
                    'https://serasaempreendedor.com.br/cadastro/resgatar-senha'),
              )) {
                throw Exception('Could not launch');
              }
            },
            child: const Text('Cadastro deslogado'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse('https://google.com'),
              )) {
                throw Exception('Could not launch');
              }
            },
            child: const Text('Google'),
          ),
        ],
      ),
    );
  }

  onPressed() {
    String imageUrl =
        'https://ipnews.com.br/wp-content/uploads/2021/05/serasa-score.png';
    sendNotification(imageUrl);
  }
}

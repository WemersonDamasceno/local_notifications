import 'package:flutter/material.dart';
import 'package:notifications_firebase/services/notification_service/notification_service.dart';
import 'package:notifications_firebase/views/inputs/inputs_page.dart';
import 'package:notifications_firebase/views/notifications/notification_page.dart';
import 'package:notifications_firebase/views/url_launcher/url_launcher_page.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _notificationService = NotificationService();
  final foneEmailController = TextEditingController();
  final cpfCnpjController = TextEditingController();

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
        title: const Text('POCs'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButtomWidget(
              title: 'Exibir notificação',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NotificationPage();
                }));
              },
            ),
            CustomButtomWidget(
              title: 'Inputs Page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const InputsPage();
                }));
              },
            ),
            CustomButtomWidget(
              title: 'Url Launcher',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UrlLauncherPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}

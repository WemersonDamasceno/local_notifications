import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notifications_firebase/services/notification_service/notification_service.dart';
import 'package:notifications_firebase/views/navigation_page.dart';
import 'package:notifications_firebase/views/score/score_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const NavigationPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/score_page') {
          final String score = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ScorePage(score: double.parse(score)),
          );
        }
        return null;
      },
    );
  }
}

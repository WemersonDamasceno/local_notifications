import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/views/home_page.dart';
import 'package:notifications_firebase/views/inputs/inputs_page.dart';
import 'package:notifications_firebase/views/loader_animation/loader_animation_page.dart';
import 'package:notifications_firebase/views/notifications/notification_page.dart';
import 'package:notifications_firebase/views/url_launcher/url_launcher_page.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POCs'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButtonWidget(
                title: 'Exibir notificação',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const NotificationPage();
                  }));
                },
              ),
              CustomButtonWidget(
                title: 'Inputs Page',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const InputsPage();
                  }));
                },
              ),
              CustomButtonWidget(
                title: 'Url Launcher',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UrlLauncherPage();
                  }));
                },
              ),
              CustomButtonWidget(
                title: 'Home Page',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                },
              ),
              CustomButtonWidget(
                title: 'Loader Animation Page',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoaderAnimationPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

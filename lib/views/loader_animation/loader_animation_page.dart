import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/loader_animation/loader_animation_widget.dart';
import 'package:notifications_firebase/views/widgets/app_bar_widget.dart';

class LoaderAnimationPage extends StatelessWidget {
  const LoaderAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: Container(
        color: const Color(0xFF71207a),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.25),
            const LoaderAnimationWidget(),
          ],
        ),
      ),
    );
  }
}

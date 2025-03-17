// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/views/home_page.dart';
import 'package:notifications_firebase/views/loader_animation/loader_animation_widget.dart';

class LoaderAnimationPage extends StatefulWidget {
  const LoaderAnimationPage({super.key});

  @override
  State<LoaderAnimationPage> createState() => _LoaderAnimationPageState();
}

class _LoaderAnimationPageState extends State<LoaderAnimationPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: const Color(0xFF71207a),
        height: size.height,
        width: size.width,
        child: const Center(
          child: LoaderAnimationWidget(
            durationInMillisecs: 600,
          ),
        ),
      ),
    );
  }
}

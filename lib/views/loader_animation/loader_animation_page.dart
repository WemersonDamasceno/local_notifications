import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/widgets/app_bar_widget.dart';

class LoaderAnimationPage extends StatefulWidget {
  const LoaderAnimationPage({super.key});

  @override
  State<LoaderAnimationPage> createState() => _LoaderAnimationPageState();
}

class _LoaderAnimationPageState extends State<LoaderAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Image.asset(
              'assets/images/serasa_logo.jpeg',
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}

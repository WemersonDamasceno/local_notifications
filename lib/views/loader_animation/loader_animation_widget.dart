import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoaderAnimationWidget extends StatefulWidget {
  final int durationInMillisecs;
  const LoaderAnimationWidget({
    super.key,
    required this.durationInMillisecs,
  });

  @override
  State<LoaderAnimationWidget> createState() => _LoaderAnimationWidgetState();
}

class _LoaderAnimationWidgetState extends State<LoaderAnimationWidget>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    for (int i = 0; i < 6; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: i == 5 ? 700 : widget.durationInMillisecs,
        ),
      );

      final animation = Tween<double>(begin: 0.0, end: 0.9).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );

      _controllers.add(controller);
      _animations.add(animation);
    }

    _startAnimationsWithDelay();
  }

  void _startAnimationsWithDelay() {
    _controllers[5].forward();
    _controllers[0].repeat(reverse: true);
    for (int i = 1; i < _controllers.length - 1; i++) {
      Future.delayed(Duration(milliseconds: i * 250), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }
  }

  Widget _buildAnimatedSquare({
    required Animation<double> animation,
    required double size,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Quadrado da esquerda
          _buildAnimatedSquare(
            animation: _animations[4],
            top: 15,
            right: 18,
            size: 15,
          ),

          // Quadrado de cima
          _buildAnimatedSquare(
            animation: _animations[3],
            top: 0,
            right: 41,
            size: 25,
          ),

          // Quadrado da direita
          _buildAnimatedSquare(
            animation: _animations[2],
            top: 24,
            left: 0,
            size: 27.5,
          ),

          // Quadrado da direita
          _buildAnimatedSquare(
            animation: _animations[1],
            bottom: 37,
            left: 7,
            size: 17,
          ),

          // Quadrado de baixo
          _buildAnimatedSquare(
            animation: _animations[0],
            bottom: 10,
            left: 27.7,
            size: 20,
          ),
          AnimatedBuilder(
            animation: _animations[5],
            builder: (context, child) {
              return Transform.scale(
                scale: _animations[5].value,
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 29,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

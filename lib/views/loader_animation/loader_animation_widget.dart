import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoaderAnimationWidget extends StatefulWidget {
  const LoaderAnimationWidget({super.key});

  @override
  State<LoaderAnimationWidget> createState() => _LoaderAnimationWidgetState();
}

class _LoaderAnimationWidgetState extends State<LoaderAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _scaleAnimation1;

  late AnimationController _controller2;
  late Animation<double> _scaleAnimation2;

  late AnimationController _controller3;
  late Animation<double> _scaleAnimation3;

  late AnimationController _controller4;
  late Animation<double> _scaleAnimation4;

  late AnimationController _controller5;
  late Animation<double> _scaleAnimation5;

  @override
  void initState() {
    super.initState();

    _controller1 = _createAnimationController()..repeat(reverse: true);
    _scaleAnimation1 = _createAnimation(_controller1);

    _controller2 = _createAnimationController();
    _scaleAnimation2 = _createAnimation(_controller2);

    _controller3 = _createAnimationController()..repeat(reverse: true);
    _scaleAnimation3 = _createAnimation(_controller3);

    _controller4 = _createAnimationController()..repeat(reverse: true);
    _scaleAnimation4 = _createAnimation(_controller4);

    _controller5 = _createAnimationController()..repeat(reverse: true);
    _scaleAnimation5 = _createAnimation(_controller5);

    // Delay de 300ms para iniciar a segunda animação
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller2.repeat(reverse: true);
    });

    // Delay de 500ms para iniciar a segunda animação
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _controller3.repeat(reverse: true);
    });

    // Delay de 350ms para iniciar a segunda animação
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _controller4.repeat(reverse: true);
    });

    // Delay de 200ms para iniciar a segunda animação
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller5.repeat(reverse: true);
    });
  }

  /// Método para criar um AnimationController
  AnimationController _createAnimationController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  /// Método para criar a animação de escala
  // Animation<double> _createAnimation(AnimationController controller) {
  //   return Tween<double>(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(parent: controller, curve: Curves.easeInOut),
  //   );
  // }

  Animation<double> _createAnimation(AnimationController controller) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  /// Método para construir o quadrado animado
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
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Quadrado superior
          _buildAnimatedSquare(
            animation: _scaleAnimation1,
            top: 2,
            size: 17,
          ),

          // Quadrado inferior
          _buildAnimatedSquare(
            animation: _scaleAnimation2,
            bottom: 5,
            left: 30,
            size: 15,
          ),

          // Quadrado direito
          _buildAnimatedSquare(
            animation: _scaleAnimation3,
            top: 14,
            right: 20,
            size: 12,
          ),

          // Quadrado esquerdo
          _buildAnimatedSquare(
            animation: _scaleAnimation4,
            top: 20,
            left: 10,
            size: 20,
          ),

          // Quadrado esquerdo
          _buildAnimatedSquare(
            animation: _scaleAnimation5,
            bottom: 30,
            left: 14,
            size: 14,
          ),

          SvgPicture.asset(
            'assets/images/logo.svg',
            width: 25,
          ),
        ],
      ),
    );
  }
}

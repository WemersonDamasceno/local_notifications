import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final EdgeInsets? margin;
  final Color baseColor;
  final String? imagePath;

  const ShimmerItem._({
    required this.width,
    required this.height,
    required this.baseColor,
    this.radius = 7,
    this.margin,
    this.imagePath,
  });

  /// Shimmer com a cor primária (roxo)
  factory ShimmerItem.primaryColor({
    required double width,
    required double height,
    double radius = 7,
    EdgeInsets? margin,
  }) {
    return ShimmerItem._(
      width: width,
      height: height,
      baseColor: const Color(0xFF53135B),
      radius: radius,
      margin: margin,
    );
  }

  /// Shimmer com a cor secundária (cinza claro)
  factory ShimmerItem.secondaryColor({
    required double width,
    required double height,
    double radius = 7,
    EdgeInsets? margin,
  }) {
    return ShimmerItem._(
      width: width,
      height: height,
      baseColor: const Color(0xFFE7E5E5),
      radius: radius,
      margin: margin,
    );
  }

  /// Shimmer aplicado em uma imagem
  factory ShimmerItem.withImage({
    required double width,
    required double height,
    required String imagePath,
    Color? baseColor,
    double radius = 7,
    EdgeInsets? margin,
  }) {
    return ShimmerItem._(
      width: width,
      height: height,
      baseColor: const Color(0xFFE7E5E5), // Cor padrão de fundo
      radius: radius,
      margin: margin,
      imagePath: imagePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: baseColor.withOpacity(0.4),
      child: imagePath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.asset(
                imagePath!,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            )
          : Container(
              margin: margin,
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
    );
  }
}

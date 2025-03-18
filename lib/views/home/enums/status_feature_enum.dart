import 'package:flutter/material.dart';

enum StatusFeatureEnum {
  inComming(
    label: 'Em breve',
    backgroundColor: Color(0xFF687DB0),
    cardColor: Color(0xFFE2E4E7),
    icon: null,
  ),
  forYou(
    label: 'Para você!',
    backgroundColor: Color(0xFFFE5b90),
    icon: 'assets/images/hands_icon.svg',
    cardColor: Color(0xFFE2E4E7),
  ),
  newFeature(
    label: 'Novo',
    icon: null,
    backgroundColor: Color(0xFF0FAC67),
    cardColor: Colors.white,
  ),
  released(
    label: null,
    backgroundColor: null,
    icon: null,
    cardColor: Colors.white,
  );

  final Color? backgroundColor;
  final Color? cardColor;
  final String? label;
  final String? icon;

  const StatusFeatureEnum({
    required this.backgroundColor,
    required this.cardColor,
    required this.label,
    required this.icon,
  });
}

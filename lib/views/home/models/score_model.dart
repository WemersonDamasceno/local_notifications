import 'package:flutter/material.dart';

class ScoreModel {
  final double scoreValue;
  final String scoreStatus;
  final Color progressBarColor;
  final Color backgroundColorStatus;
  final Color fontColorStatus;

  ScoreModel({
    required this.scoreValue,
    required this.scoreStatus,
    required this.progressBarColor,
    required this.backgroundColorStatus,
    required this.fontColorStatus,
  });
}

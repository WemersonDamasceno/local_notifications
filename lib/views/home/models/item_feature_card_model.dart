import 'dart:ui';

import 'package:notifications_firebase/views/home/enums/status_feature_enum.dart';

class ItemFeatureCardModel {
  final String title;
  final String? description;
  final String image;
  final StatusFeatureEnum statusFeature;
  final VoidCallback onTap;

  ItemFeatureCardModel({
    required this.title,
    required this.image,
    required this.onTap,
    this.statusFeature = StatusFeatureEnum.released,
    this.description,
  });
}

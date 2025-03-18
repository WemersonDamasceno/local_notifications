import 'package:flutter/material.dart';
import 'package:notifications_firebase/utils/app_breakpoints.dart';

extension MediaQueryExtensions on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  bool get isSmallScreen => screenSize.width < AppBreakpoints.small;
  bool get isMediumScreen =>
      screenSize.width >= AppBreakpoints.small &&
      screenSize.width < AppBreakpoints.medium;
  bool get isLargeScreen => screenSize.width >= AppBreakpoints.medium;
}

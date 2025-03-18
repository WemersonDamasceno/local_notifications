import 'package:flutter/material.dart';
import 'package:notifications_firebase/utils/extensions/media_query_extension.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Size? sizeButton;
  final Icon? icon;

  const CustomButtonWidget._({
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    this.sizeButton,
    this.icon,
  });

  factory CustomButtonWidget({
    required String title,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.black,
    Size? sizeButton,
  }) {
    return CustomButtonWidget._(
      title: title,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      sizeButton: sizeButton,
    );
  }

  factory CustomButtonWidget.withIcon({
    required String title,
    required VoidCallback onPressed,
    required Icon icon,
    Color backgroundColor = Colors.black,
    Size? sizeButton,
  }) {
    return CustomButtonWidget._(
      title: title,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      icon: icon,
      sizeButton: sizeButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeButton?.width,
      height: sizeButton?.height,
      child: icon != null
          ? ElevatedButton.icon(
              style: _buttonStyle(),
              onPressed: onPressed,
              icon: icon!,
              label: _buttonText(context),
            )
          : ElevatedButton(
              style: _buttonStyle(),
              onPressed: onPressed,
              child: _buttonText(context),
            ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buttonText(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: context.isSmallScreen ? 12 : 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

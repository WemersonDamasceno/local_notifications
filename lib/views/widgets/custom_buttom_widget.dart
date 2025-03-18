import 'package:flutter/material.dart';

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

  /// Factory para criar um botão sem ícone
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

  /// Factory para criar um botão com ícone
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
              label: _buttonText(),
            )
          : ElevatedButton(
              style: _buttonStyle(),
              onPressed: onPressed,
              child: _buttonText(),
            ),
    );
  }

  /// Estilo do botão
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  /// Texto do botão
  Widget _buttonText() {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

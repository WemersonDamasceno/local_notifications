import 'package:flutter/material.dart';
import 'package:notifications_firebase/utils/extensions/media_query_extension.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class UserInfoErroWidget extends StatelessWidget {
  final VoidCallback onRefresh;

  const UserInfoErroWidget({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Falha ao carregar seus dados',
          style: TextStyle(
            color: Colors.white,
            fontSize: context.isSmallScreen ? 13 : 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomButtonWidget.withIcon(
          title: 'Recarregar',
          icon: const Icon(Icons.refresh),
          backgroundColor: const Color(0xFF2A5595),
          onPressed: () => onRefresh(),
        ),
      ],
    );
  }
}

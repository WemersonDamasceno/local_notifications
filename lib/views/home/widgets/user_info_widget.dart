import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String userName;
  final String cnpjOrCpf;

  const UserInfoWidget({
    super.key,
    required this.userName,
    required this.cnpjOrCpf,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá, $userName 👋',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'CNPJ $cnpjOrCpf',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/inputs/formatters/phone_email_formatter/phone_or_email_formatter.dart';
import 'package:notifications_firebase/views/widgets/custom_input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherPage extends StatefulWidget {
  const UrlLauncherPage({super.key});

  @override
  State<UrlLauncherPage> createState() => _UrlLauncherPageState();
}

class _UrlLauncherPageState extends State<UrlLauncherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Launcher Page'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ElevatedButton(
                        onPressed: launcherUrl,
                        child: const Text('Regatar Senha'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomInputWidget(
                        label: 'Fone/Email',
                        formatters: [PhoneOrEmailFormatter()],
                        controller: TextEditingController(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void launcherUrl() async {
    if (!await launchUrl(
      Uri.parse('https://serasaempreendedor.com.br/cadastro-deslogado'),
    )) {
      throw Exception('Could not launch');
    }
  }
}

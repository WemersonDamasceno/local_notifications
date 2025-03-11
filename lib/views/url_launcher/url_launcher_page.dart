import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text('Pagina na internet')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(
                      'https://serasaempreendedor.com.br/cadastro-deslogado'),
                )) {
                  throw Exception('Could not launch');
                }
              },
              child: const Text('Regatar Senha'),
            ),
          ],
        ),
      ),
    );
  }
}

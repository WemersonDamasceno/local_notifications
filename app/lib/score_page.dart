import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final String score;

  const ScorePage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '$score de 1000',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Seu score está bom',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Detalhes do seu score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.assessment),
                    title: Text('Fator 1: Histórico de Pagamentos'),
                    subtitle: Text('100% positivo'),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Fator 2: Utilização de Crédito'),
                    subtitle: Text('30% utilizado'),
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Fator 3: Tempo de Conta'),
                    subtitle: Text('5 anos'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

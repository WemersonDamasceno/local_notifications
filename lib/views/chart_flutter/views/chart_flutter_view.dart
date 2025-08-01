import 'package:flutter/material.dart';

class ChartFlutterView extends StatelessWidget {
  const ChartFlutterView({super.key});

  final int oldScore = 2;
  final int currentScore = 900;
  final int maxScore = 1000;

  @override
  Widget build(BuildContext context) {
    final int diff = currentScore - oldScore;
    final bool isPositive = diff >= 0;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gráfico de barras
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar(
                              value: oldScore,
                              color: Colors.grey[300]!,
                              label: '8/ago\n2024',
                            ),
                            const SizedBox(width: 8),
                            _buildBar(
                              value: currentScore,
                              color: Colors.pink,
                              label: 'Score\nAtual',
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Informações de texto
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isPositive
                                    ? '📈 Aumento de'
                                    : '📉 Decréscimo de',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${diff.abs()} pts',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: isPositive ? Colors.green : Colors.red,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'da última atualização',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBar({
    required int value,
    required Color color,
    required String label,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Stack que desenha a barra e o valor logo acima
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxHeight = constraints.maxHeight;
              final double ratio = value / maxScore;
              final double barHeight =
                  (maxHeight * ratio).clamp(1.0, maxHeight);

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Barra proporcional
                  Container(
                    width: 30,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  // Valor logo acima da barra
                  Positioned(
                    bottom: barHeight + 4,
                    child: Text(
                      value.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

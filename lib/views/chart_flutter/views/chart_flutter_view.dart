import 'package:flutter/material.dart';

class ScoreBar {
  final int value;
  final DateTime date;

  ScoreBar({required this.value, required this.date});
}

class ChartFlutterView extends StatefulWidget {
  const ChartFlutterView({super.key});

  @override
  State<ChartFlutterView> createState() => _ChartFlutterViewState();
}

class _ChartFlutterViewState extends State<ChartFlutterView> {
  String formatDate(DateTime date) {
    const months = {
      1: 'jan',
      2: 'fev',
      3: 'mar',
      4: 'abr',
      5: 'mai',
      6: 'jun',
      7: 'jul',
      8: 'ago',
      9: 'set',
      10: 'out',
      11: 'nov',
      12: 'dez',
    };

    final month = months[date.month] ?? '';
    return "${date.day}/$month\n${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    // Lista inicial de Scores
    final List<ScoreBar> scores = [
      ScoreBar(value: 500, date: DateTime(2024, 8, 8)),
      ScoreBar(value: 720, date: DateTime(2024, 8, 9)),
      ScoreBar(value: 820, date: DateTime(2024, 8, 10)),
      ScoreBar(value: 898, date: DateTime(2024, 8, 11)), // Score Atual
    ];
    final ScoreBar oldScore = scores.first;
    final ScoreBar currentScore = scores.last;

    final int diff = currentScore.value - oldScore.value;
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
                padding: const EdgeInsets.all(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double barsWidth = constraints.maxWidth * 0.45;
                    final double textWidth = constraints.maxWidth * 0.55;

                    // Quantas barras cabem (mínimo 40px cada incluindo espaço)
                    const double barMinWidth = 40;
                    final int maxBars = (barsWidth / barMinWidth)
                        .floor()
                        .clamp(1, scores.length);

                    // Sempre pega do final para mostrar pelo menos a última
                    final List<ScoreBar> visibleScores = scores
                        .sublist(scores.length - maxBars) // pega do final
                        .toList();

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: barsWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (final score in visibleScores) ...[
                                _buildBar(
                                  value: score.value,
                                  color: score == currentScore
                                      ? Colors.pink
                                      : Colors.grey[300]!,
                                  label: score == currentScore
                                      ? 'Score\nAtual'
                                      : formatDate(score.date),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(
                          width: textWidth,
                          child: Container(
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
                                FittedBox(
                                  child: Text(
                                    '${diff.abs()} pts',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: isPositive
                                          ? Colors.green
                                          : Colors.red,
                                    ),
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
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const int maxScore = 1000;
                final double maxHeight = constraints.maxHeight;
                final double ratio = value / maxScore;
                final double barHeight =
                    (maxHeight * ratio).clamp(1.0, maxHeight);

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: 30,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
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
      ),
    );
  }
}

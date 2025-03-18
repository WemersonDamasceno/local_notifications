import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/score/widgets/score_progress_widget.dart';
import 'package:notifications_firebase/views/score/widgets/status_score_widget.dart';

class ScoreCard extends StatelessWidget {
  final double score;
  final int maxScore = 1000;

  const ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "O Score da sua empresa",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TweenAnimationBuilder<int>(
                  duration: const Duration(milliseconds: 700),
                  tween: IntTween(begin: 0, end: score.toInt()),
                  builder: (context, value, child) {
                    return Text(
                      '$value',
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                const StatusScoreWidget(statusScore: 'Excelente'),
              ],
            ),
            const SizedBox(height: 12),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 700),
              tween: Tween<double>(begin: 0, end: score),
              builder: (context, animatedScore, child) {
                return ScoreProgressBarWidget(
                  score: animatedScore,
                  barColor: const Color(0xFF019E44),
                );
              },
            ),
            const SizedBox(height: 16),
            // Center(
            //   child: OutlineButtonWidget(
            //     label: 'Veja como melhorar seu Score',
            //     onPressed: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/score/widgets/outline_button_widget.dart';
import 'package:notifications_firebase/views/score/widgets/score_progress_widget.dart';
import 'package:notifications_firebase/views/score/widgets/status_score_widget.dart';

class ScoreCard extends StatelessWidget {
  final double score;
  final int maxScore = 1000;

  const ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TitleCard(),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TweenAnimationBuilder<int>(
                  duration: const Duration(seconds: 1),
                  tween: IntTween(begin: 0, end: score.toInt()),
                  builder: (context, value, child) {
                    return Text(
                      '$value',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                const StatusScoreWidget(statusScore: 'Boa'),
              ],
            ),
            const SizedBox(height: 12),
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: score),
              builder: (context, animatedScore, child) {
                return ScoreProgressBarWidget(
                  score: animatedScore,
                  barColor: const Color(0xFFb4e648),
                );
              },
            ),
            const SizedBox(height: 12),
            Center(
              child: OutlineButtonWidget(
                label: 'Veja como melhorar seu Score',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard();
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "O Score da sua empresa",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(width: 4),
        Icon(
          Icons.info,
          size: 16,
          color: Color(0xFFcccccc),
        )
      ],
    );
  }
}

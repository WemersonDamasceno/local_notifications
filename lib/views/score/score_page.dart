import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/score/score_widget.dart';

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
            ScoreCard(score: double.parse(score)),
          ],
        ),
      ),
    );
  }
}

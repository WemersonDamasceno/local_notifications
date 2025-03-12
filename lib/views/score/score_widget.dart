import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final double score;
  final int maxScore = 1000;

  const ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    // double progress = score / maxScore;
    final size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "O Score da sua empresa",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  score.toInt().toString(),
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 187, 200, 188),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Boa",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 60, 55),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            //TODO: For tests
            SizedBox(
              width: size.width,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: LinearProgressIndicator(
                  value: 0.68,
                  minHeight: 10,
                  backgroundColor: Colors.grey[300],
                  color: Colors.lightGreen,
                ),
              ),
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: size.width * 0.22,
            //       child: ClipRRect(
            //         borderRadius: const BorderRadius.only(
            //           bottomLeft: Radius.circular(12),
            //           topLeft: Radius.circular(12),
            //         ),
            //         child: LinearProgressIndicator(
            //           value: 10,
            //           minHeight: 10,
            //           backgroundColor: Colors.grey[300],
            //           color: Colors.lightGreen,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     SizedBox(
            //       width: size.width * 0.13,
            //       child: ClipRRect(
            //         child: LinearProgressIndicator(
            //           value: 1,
            //           minHeight: 10,
            //           backgroundColor: Colors.grey[300],
            //           color: Colors.lightGreen,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     SizedBox(
            //       width: size.width * 0.20,
            //       child: ClipRRect(
            //         child: LinearProgressIndicator(
            //           value: 0.6,
            //           minHeight: 10,
            //           backgroundColor: Colors.grey[300],
            //           color: Colors.lightGreen,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     SizedBox(
            //       width: size.width * 0.20,
            //       child: ClipRRect(
            //         borderRadius: const BorderRadius.only(
            //           bottomRight: Radius.circular(12),
            //           topRight: Radius.circular(12),
            //         ),
            //         child: LinearProgressIndicator(
            //           value: 0,
            //           minHeight: 10,
            //           backgroundColor: Colors.grey[300],
            //           color: Colors.lightGreen,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0"),
                Text("500"),
                Text("1000"),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Veja como melhorar seu Score"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

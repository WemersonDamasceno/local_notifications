import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/score/widgets/row_score_widget.dart';

class ScoreProgressBarWidget extends StatelessWidget {
  final double score;
  final Color barColor;

  const ScoreProgressBarWidget({
    super.key,
    required this.score,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, 12),
              painter: ScoreProgressPainter(
                score: score,
                barColor: barColor,
              ),
            ),
            const SizedBox(height: 8),
            const RowScoreWidget(),
          ],
        );
      },
    );
  }
}

class ScoreProgressPainter extends CustomPainter {
  final double score;
  final Color barColor;
  final Color backgroundColor;

  final List<double> segmentPercents = [0.10, 0.13, 0.20, 0.57];
  final double spacing = 4.0;
  final double maxScore = 1000;

  ScoreProgressPainter({
    super.repaint,
    required this.score,
    required this.barColor,
    this.backgroundColor = const Color(0xFFcccccc),
  });

  @override
  void paint(Canvas canvas, Size size) {
    double currentX = 0;
    double accumulatedScore = 0;

    // Ajustando a largura disponível para os segmentos, considerando o espaçamento
    double totalSpacing = (segmentPercents.length - 1) * spacing;
    double availableWidth = size.width - totalSpacing;

    // Desenha todos os segmentos de fundo (cinza)
    for (int i = 0; i < segmentPercents.length; i++) {
      double segmentWidth = segmentPercents[i] * availableWidth;
      double segmentScore = segmentPercents[i] * maxScore;
      accumulatedScore += segmentScore;

      // Desenha o fundo do segmento (sempre cinza)
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;

      // Calcula o valor para os radius da barra cinza
      double leftRadius = (i == 0) ? 10 : 0;
      double rightRadius = (i == segmentPercents.length - 1) ? 10 : 0;

      // Desenha os seguimentos cinzas
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(currentX, 0, segmentWidth, size.height),
          topLeft: Radius.circular(leftRadius),
          bottomLeft: Radius.circular(leftRadius),
          topRight: Radius.circular(rightRadius),
          bottomRight: Radius.circular(rightRadius),
        ),
        backgroundPaint,
      );

      // Avança para o próximo segment
      currentX += segmentWidth + spacing;
    }

    // Agora, desenha os segmentos verdes (preenchidos) de acordo com a pontuação
    currentX = 0;
    accumulatedScore = 0;

    for (int i = 0; i < segmentPercents.length; i++) {
      double segmentWidth = segmentPercents[i] * availableWidth;
      double segmentScore = segmentPercents[i] * maxScore;
      accumulatedScore += segmentScore;

      // Configuração da pintura do segmento preenchido (verde)
      final Paint segmentPaint = Paint()
        ..color = barColor
        ..style = PaintingStyle.fill;

      // Adiciona o radios para o primeiro item do lado esquerdo
      double leftRadius = (i == 0) ? 10 : 0;
      double rightRadius = (i == segmentPercents.length - 1) ? 10 : 0;
      if (score <= accumulatedScore) {
        rightRadius = 10;
      }

      // Se o valor do score for maior que o daquele seguimento
      // preenche o segmento completo
      if (score >= accumulatedScore) {
        canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(currentX, 0, segmentWidth, size.height),
            topLeft: Radius.circular(leftRadius),
            bottomLeft: Radius.circular(leftRadius),
            topRight: Radius.circular(rightRadius),
            bottomRight: Radius.circular(rightRadius),
          ),
          segmentPaint,
        );
      } else if (score > accumulatedScore - segmentScore) {
        // Preenche parcialmente o segmento atual
        double fillPercent =
            (score - (accumulatedScore - segmentScore)) / segmentScore;
        double fillWidth = fillPercent * segmentWidth;

        canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(currentX, 0, fillWidth, size.height),
            topLeft: Radius.circular(leftRadius),
            bottomLeft: Radius.circular(leftRadius),
            topRight: Radius.circular(rightRadius),
            bottomRight: Radius.circular(rightRadius),
          ),
          segmentPaint,
        );
        break;
      }

      // Avança para o próximo segment
      currentX += segmentWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

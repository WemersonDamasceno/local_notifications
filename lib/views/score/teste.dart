import 'package:flutter/material.dart';

class ScoreProgressPainter2 extends CustomPainter {
  final double score;

  ScoreProgressPainter2(this.score);

  final List<double> segmentPercents = [0.25, 0.18, 0.12, 0.45];
  final double spacing = 8.0;
  final Color barColor = Colors.green;
  final Color backgroundColor = Colors.grey.withOpacity(0.3);
  final double maxScore = 1000;

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

      double leftRadius = (i == 0) ? 10 : 0;
      double rightRadius = (i == segmentPercents.length - 1) ? 10 : 0;

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

      double leftRadius = (i == 0) ? 10 : 0;
      double rightRadius = (i == segmentPercents.length - 1) ? 10 : 0;
      if (score <= accumulatedScore) {
        rightRadius = 10;
      }

      if (score >= accumulatedScore) {
        // Preenche o segmento completo
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
        break; // Sai do loop pois não há mais preenchimento necessário
      }

      currentX += segmentWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

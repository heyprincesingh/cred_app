import 'package:cred_stack/utils/curreny_converter.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircularRangeSlider extends StatefulWidget {
  final String header;
  final String description;
  final double maxRange;
  final double minRange;
  final double initialValue;
  final ValueChanged<double>? onChange;

  const CircularRangeSlider({
    Key? key,
    required this.header,
    required this.description,
    required this.maxRange,
    required this.minRange,
    required this.initialValue,
    this.onChange,
  }) : super(key: key);

  @override
  _CircularRangeSliderState createState() => _CircularRangeSliderState();
}

class _CircularRangeSliderState extends State<CircularRangeSlider> {
  late double _currentValue;
  late double _dragAngle;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _dragAngle = _valueToAngle(_currentValue);
  }

  double _valueToAngle(double value) {
    double normalizedValue = (value - widget.minRange) / (widget.maxRange - widget.minRange);
    return 2 * pi * normalizedValue - pi / 2;
  }

  double _angleToValue(double angle) {
    angle += pi / 2;
    if (angle < 0) angle += 2 * pi;
    double normalizedAngle = angle / (2 * pi);
    return widget.minRange + normalizedAngle * (widget.maxRange - widget.minRange);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: (details) {
          final center = Offset(150, 150);
          final dx = details.localPosition.dx - center.dx;
          final dy = details.localPosition.dy - center.dy;

          final distance = sqrt(dx * dx + dy * dy);
          final radius = 150.0;

          if (distance <= radius) {
            double newAngle = atan2(dy, dx);

            double newValue = _angleToValue(newAngle).clamp(widget.minRange, widget.maxRange);

            setState(() {
              _dragAngle = newAngle;
              _currentValue = newValue;

              if (widget.onChange != null) {
                widget.onChange!(_currentValue);
              }
            });
          }
        },
        child: CustomPaint(
          size: Size(300, 300),
          painter: CircularRangeSliderPainter(
            currentValue: _currentValue,
            maxRange: widget.maxRange,
            minRange: widget.minRange,
            header: widget.header,
            description: widget.description,
            dragAngle: _dragAngle,
          ),
        ),
      ),
    );
  }
}

class CircularRangeSliderPainter extends CustomPainter {
  final double currentValue;
  final double maxRange;
  final double minRange;
  final String header;
  final String description;
  final double dragAngle;

  CircularRangeSliderPainter({
    required this.currentValue,
    required this.maxRange,
    required this.minRange,
    required this.header,
    required this.description,
    required this.dragAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final Paint selectedPaint = Paint()
      ..color = Color(0xff935a46)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final Paint unselectedPaint = Paint()
      ..color = Colors.red.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 30;

    canvas.drawCircle(center, radius, backgroundPaint);

    double selectedAngle = _valueToAngle(currentValue);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      selectedAngle + pi / 2,
      false,
      selectedPaint,
    );

    double unselectedAngle = _valueToAngle(maxRange) - selectedAngle;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + selectedAngle + pi / 2,
      unselectedAngle,
      false,
      unselectedPaint,
    );

    _drawCenteredText(canvas, size, header, 16, center.dy - 35, isBold: true);
    _drawCenteredText(canvas, size, convertCurrencyIntoString(currentValue.toStringAsFixed(0)), 32, center.dy - 10, isBold: true);
    _drawCenteredText(canvas, size, description, 14, center.dy + 35, textColor: Colors.green);

    double knobX = center.dx + radius * cos(dragAngle);
    double knobY = center.dy + radius * sin(dragAngle);
    canvas.drawCircle(Offset(knobX, knobY), 10, Paint()..color = Colors.black);
  }

  void _drawCenteredText(Canvas canvas, Size size, String text, double fontSize, double yOffset, {Color textColor = Colors.black, bool isBold = false}) {
    TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    painter.paint(canvas, Offset(size.width / 2 - painter.width / 2, yOffset));
  }

  double _valueToAngle(double value) {
    double normalizedValue = (value - minRange) / (maxRange - minRange);
    return 2 * pi * normalizedValue - pi / 2;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

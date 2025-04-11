import 'dart:math';
import 'package:flutter/material.dart';

class CaptchaWidget extends StatefulWidget {
  final Function(bool) onValidated;

  const CaptchaWidget({Key? key, required this.onValidated}) : super(key: key);

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  late String _captchaText;
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    _captchaText = String.fromCharCodes(
      Iterable.generate(
        6,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          CustomPaint(
            size: const Size(200, 60),
            painter: CaptchaPainter(_captchaText),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ingrese el texto',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isValid = value.toUpperCase() == _captchaText;
                      widget.onValidated(_isValid);
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _generateCaptcha();
                    _controller.clear();
                    _isValid = false;
                    widget.onValidated(false);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CaptchaPainter extends CustomPainter {
  final String text;

  CaptchaPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    final random = Random();

    // Dibujar líneas aleatorias de fondo
    for (int i = 0; i < 10; i++) {
      canvas.drawLine(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        paint,
      );
    }

    // Dibujar el texto distorsionado
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < text.length; i++) {
      final charSpan = TextSpan(text: text[i], style: textStyle);
      final charPainter = TextPainter(
        text: charSpan,
        textDirection: TextDirection.ltr,
      );
      charPainter.layout();

      canvas.save();
      final x = (size.width / text.length) * i + 10;
      final y = size.height / 2;
      canvas.translate(x, y);
      canvas.rotate((random.nextDouble() - 0.5) * 0.5);
      charPainter.paint(
        canvas,
        Offset(-charPainter.width / 2, -charPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

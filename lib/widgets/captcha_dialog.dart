import 'package:flutter/material.dart';
import 'package:prueba_lunes_17/widgets/captcha_widget.dart';

class CaptchaDialog extends StatelessWidget {
  final Function(bool) onValidated;

  const CaptchaDialog({Key? key, required this.onValidated}) : super(key: key);

  static Future<void> show(BuildContext context, Function(bool) onValidated) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (BuildContext context) => CaptchaDialog(onValidated: onValidated),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(32, 35, 41, 1),
      title: const Text(
        'Verificación de Seguridad',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CaptchaWidget(
            onValidated: (isValid) {
              if (isValid) {
                onValidated(true);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
          onPressed: () {
            onValidated(false);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

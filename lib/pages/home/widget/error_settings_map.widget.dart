import 'package:flutter/material.dart';

class ErrorSettingsMap extends StatelessWidget {
  final String textError;
  final String textButton;
  final void Function() onPressed;

  const ErrorSettingsMap({
    super.key,
    required this.textError,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textError, textAlign: .center, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            OutlinedButton(onPressed: onPressed, child: Text(textButton)),
          ],
        ),
      ),
    );
  }
}

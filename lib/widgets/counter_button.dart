import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color? color;

  const CounterButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(texto),
      );
  }
}
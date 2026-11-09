import 'package:flutter/material.dart';
import 'package:vendeme_agency_front/widgets/counter_button.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int contador = 0;

  void incrementar() {
    setState(() {
      contador++;
    });
  }

  void disminuir() {
    if (contador > 0) {
      setState(() {
        contador--;
      });
    }
  }

  void reiniciar() {
    setState(() {
      contador = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprendiendo Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'My Counter',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              '$contador',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterButton(
                  texto: '-',
                  onPressed: disminuir,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                CounterButton(
                  texto: '+',
                  onPressed: incrementar,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 10),
            CounterButton(
              texto: 'Reiniciar',
              onPressed: reiniciar,
              color: Colors.orange,
            ),
          ],
        )
      )
    );
  }
}
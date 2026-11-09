import 'package:flutter/material.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  final nombreController = TextEditingController();

  String saludo = 'Escribe tu nombre';

  void saludar() {

    final nombre = nombreController.text.trim();

    if (nombre.isNotEmpty) {
      setState(() {
      saludo = 'Hola, $nombre';
    });
    }
  }

  void limpiar() {
    nombreController.clear();

    setState(() {
      saludo = 'Escribe tu nombre';
    });
  }

  @override
  void dispose() {
    nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprendiendo TextField'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Volver'),
            ),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Escribe tu nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: saludar, 
                  child: const Text('Saludar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: limpiar, 
                  child: const Text('Limpiar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              saludo,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ),
    );
  }
}
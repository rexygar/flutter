import 'package:flutter/material.dart';

class DashoboardMenu extends StatelessWidget{
  final VoidCallback onInicio;
  final VoidCallback onUsuarios;
  final VoidCallback onConfiguracion;
  final VoidCallback onPublicacion;

  const DashoboardMenu({
    super.key,
    required this.onInicio,
    required this.onUsuarios,
    required this.onConfiguracion,
    required this.onPublicacion,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Mi panel',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Inicio'),
          onTap: onInicio,
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Usuarios'),
          onTap: onUsuarios,
        ),
        ListTile(
          leading: const Icon(Icons.post_add),
          title: const Text('Publicaciones'),
          onTap: onPublicacion,
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configuracion'),
          onTap: onConfiguracion,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:vendeme_agency_front/models/usuario.dart';
import 'package:vendeme_agency_front/services/usuario_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final usuarioService = UsuarioService();

  late Future<List<Usuario>> usuariosFuture;

  @override
  void initState() {
    super.initState();
    usuariosFuture = usuarioService.obtenerUsuarios();
  }

  void recargar() {
    setState(() {
      usuariosFuture = usuarioService.obtenerUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List de usuarios'),
        actions: [
          IconButton(
            onPressed: recargar,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Usuario>>(
        future: usuariosFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final usuarios = snapshot.data ?? [];

          if (usuarios.isEmpty) {
            return const Center(
              child: Text('No hay usuarios'),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: recargar,
                  child: const Text('Recargar API'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    final usuario = usuarios[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(usuario.nombre[0]),
                      ),
                      title: Text(
                        usuario.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('@${usuario.username}'),
                          const SizedBox(height: 4),
                          Text(usuario.correo),
                        ],
                      ),
                      isThreeLine: true,
                    );
                  },
                )
              )
            ],
          );
        })
      )
    );
  }
}
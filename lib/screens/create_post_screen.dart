import 'package:flutter/material.dart';
import 'package:vendeme_agency_front/models/publicacion.dart';
import 'package:vendeme_agency_front/services/publicacion_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final formkey = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final contenidoController = TextEditingController();

  final publicacionService = PublicacionService();

  bool cargando = false;
  Publicacion? resultado;

  Future<void> crear() async {
    if (cargando) return;

    if (!formkey.currentState!.validate()) {
      return;
    }

    setState(() {
      cargando = true;
      resultado = null;
    });

    try {
      final publicacion = Publicacion(
        userId: 1,
        titulo: tituloController.text.trim(),
        contenido: contenidoController.text.trim(),
      );

      final respuesta = await publicacionService.crearPublicacion(publicacion);

      if (!mounted) return;

      setState(() {
        resultado = respuesta;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Petición exitosa')));
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    } finally {
      if (mounted) {
        setState(() {
          cargando = false;
        });
      }
    }
  }

  void limpiar() {
    if (cargando) return;

    formkey.currentState?.reset();
    tituloController.clear();
    contenidoController.clear();

    setState(() {
      resultado = null;
    });
  }

  @override
  void dispose() {
    tituloController.dispose();
    contenidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear publicación')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa un titulo';
                    }

                    if (value.trim().length < 5) {
                      return 'El titulo debe tener por lo menos 5 caracteres';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: contenidoController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Contenido',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa el contenido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: cargando ? null : crear,
                      child: cargando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Crear publicación'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: cargando ? null : limpiar,
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (resultado != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('ID: ${resultado!.id}'),
                      const SizedBox(height: 8),
                      Text('titulo: ${resultado!.titulo}'),
                      const SizedBox(height: 8),
                      Text('contenido: ${resultado!.contenido}'),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

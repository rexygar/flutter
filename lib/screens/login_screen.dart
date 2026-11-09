import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  bool mostrarPassword = false;

  bool cargando = false;

 Future<void> ingresar() async {
  if (cargando) return;

  if (!formKey.currentState!.validate()) {
    return;
  }

  setState(() {
    cargando = true;
  });

  try {
    await Future.delayed(
      const Duration(seconds: 2)
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inicio de sesión simulado'),
      ),
    );
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oucrrió un error inesperado'),
      )
    );

    debugPrint('Error: $error');
  } finally {
    if (mounted) {
      setState(() {
        cargando = false;
      });
    }
  }
 }

  void limpiar() {
    formKey.currentState?.reset();
    correoController.clear();
    passwordController.clear();

    setState(() {
      mostrarPassword = false;
    });
  }

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprendiendo formularios'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: correoController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu correo';
                    }

                    if (!regex.hasMatch(value.trim())) {
                      return 'Ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: !mostrarPassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        mostrarPassword 
                          ? Icons.visibility_off 
                          : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          mostrarPassword = !mostrarPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa tu contraseña';
                    }

                    if (value.length < 8) {
                      return 'Minimo 8 caracteres';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: cargando ? null : ingresar,
                      child: cargando
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                        : const Text('Ingresar'),
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton(
                      onPressed: cargando ? null : limpiar, 
                      child: const Text('Limpiar')
                    ),
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
import 'package:flutter/material.dart';
import 'package:vendeme_agency_front/screens/counter_screen.dart';
import 'package:vendeme_agency_front/screens/create_post_screen.dart';
import 'package:vendeme_agency_front/screens/greeting_screen.dart';
import 'package:vendeme_agency_front/screens/login_screen.dart';
import 'package:vendeme_agency_front/screens/users_screen.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  void navegar(BuildContext context, Widget pantalla) {
    Navigator.push(
      context, 
      MaterialPageRoute<void>(
        builder: (context) => pantalla,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi aplicación Flutter'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Menú principal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.waving_hand),
            title: const Text('Saludar'),
            subtitle: const Text('Saludo al usuario'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              navegar(context, const GreetingScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Lista de usuarios'),
            subtitle: const Text('Consultar usuarios con GET'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              navegar(context, const UsersScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('Crear publicación'),
            subtitle: const Text('Enviar datos mediante POST'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              navegar(context, const CreatePostScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Iniciar Sesión'),
            subtitle: const Text('Formulario y validaciones'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              navegar(context, const LoginScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Contador'),
            subtitle: const Text('Practicar estado local'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              navegar(context, const CounterScreen());
            },
          ),
        ],
      )
    );
  }
}
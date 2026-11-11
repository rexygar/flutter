import 'package:flutter/material.dart';
import 'package:vendeme_agency_front/screens/configuration_screen.dart';
import 'package:vendeme_agency_front/screens/counter_screen.dart';
import 'package:vendeme_agency_front/screens/create_post_screen.dart';
import 'package:vendeme_agency_front/screens/dashboard_screen.dart';
import 'package:vendeme_agency_front/screens/greeting_screen.dart';
import 'package:vendeme_agency_front/screens/login_screen.dart';
import 'package:vendeme_agency_front/screens/users_screen.dart';
import 'package:vendeme_agency_front/state/app_settings.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({
    super.key,
    });

  void navegar(BuildContext context, Widget pantalla) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => pantalla),
    );
  }

  Widget crearTarjeta({
    required BuildContext context,
    required String titulo,
    required String descripcion,
    required IconData icono,
    required Widget pantalla,
    Color? color,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => navegar(context, pantalla),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icono, 
                size: 32,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi aplicación Flutter')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final ancho = constraints.maxWidth;

          int columnas;

          if (ancho < 700) {
            columnas = 1;
          } else if (ancho < 1200) {
            columnas = 2;
          } else {
            columnas = 4;
          }

          return GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: columnas,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 170,
            children: [
              crearTarjeta(
                context: context,
                titulo: 'Saludar',
                descripcion: 'Saludo personalizado',
                icono: Icons.waving_hand,
                pantalla: const GreetingScreen(),
              ),
              crearTarjeta(
                context: context,
                titulo: 'Usuarios',
                descripcion: 'Consultar usuarios con GET',
                icono: Icons.people,
                pantalla: const UsersScreen(),
              ),
              crearTarjeta(
                context: context,
                titulo: 'Crear publicación',
                descripcion: 'Enviar información con POST',
                icono: Icons.add_box,
                pantalla: const CreatePostScreen(),
              ),
              crearTarjeta(
                context: context,
                titulo: 'Iniciar sesión',
                descripcion: 'Formulario con validaciones',
                icono: Icons.login,
                pantalla: const LoginScreen(),
              ),
              crearTarjeta(
                context: context,
                titulo: 'Contador',
                descripcion: 'Practicar estado local',
                icono: Icons.calculate,
                pantalla: const CounterScreen(),
              ),
              crearTarjeta(
                context: context,
                titulo: 'Configuración',
                descripcion: 'Pantalla de configuración',
                icono: Icons.settings,
                pantalla: const ConfigurationScreen(),
              ),
              crearTarjeta(
                context: context,
                titulo: 'Dashboard',
                descripcion: 'Panel administrativo responsivo',
                icono: Icons.dashboard,
                pantalla: const DashboardScreen(),
                color: Colors.indigo,
              ),
            ],
          );
        },
      ),
    );
  }
}

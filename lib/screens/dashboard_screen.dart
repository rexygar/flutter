import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendeme_agency_front/state/app_settings.dart';

import 'package:vendeme_agency_front/screens/configuration_screen.dart';
import 'package:vendeme_agency_front/screens/create_post_screen.dart';
import 'package:vendeme_agency_front/screens/users_screen.dart';
import 'package:vendeme_agency_front/state/app_settings.dart';
import 'package:vendeme_agency_front/widgets/dashoboard_menu.dart';
import 'package:vendeme_agency_front/widgets/statistic_card.dart';

class DashboardScreen extends ConsumerWidget{
  
  const DashboardScreen({
    super.key,
  });

  void navegar(BuildContext context, Widget pantalla) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => pantalla,
      )
    );
  }

  Widget construirContenido() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columnas;

        if (constraints.maxWidth < 650) {
          columnas = 1;
        } else if (constraints.maxWidth < 1199) {
          columnas = 2;
        } else {
          columnas = 3;
        }

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columnas,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 130,
          children: const [
            StatisticCard(
              titulo: 'Usuarios',
              valor: '128',
              icono: Icons.people,
              color: Colors.blue,
            ),
            StatisticCard(
              titulo: 'Publicaciones',
              valor: '42',
              icono: Icons.article,
              color: Colors.green,
            ),
            StatisticCard(
              titulo: 'Archivos',
              valor: '96',
              icono: Icons.check_circle,
              color: Colors.teal,
            ),
            StatisticCard(
              titulo: 'Pendientes',
              valor: '8',
              icono: Icons.schedule,
              color: Colors.orange,
            ),
            StatisticCard(
              titulo: 'Ventas',
              valor: '24',
              icono: Icons.money,
              color: Colors.yellow
            )
          ],
        );
      },
    );
  }

  Widget construirMenu(BuildContext context, {bool esDrawer = false,}) {
    void abrirPantalla(Widget pantalla) {
      final navigator = Navigator.of(context);

      if (esDrawer) {
        navigator.pop();
      }

      navigator.push(
        MaterialPageRoute<void>(
          builder: (_) => pantalla,
        ),
      );
    }

    return DashoboardMenu(
      onInicio: () {
        if (esDrawer) {
          Navigator.pop(context);
        }
      },
      onUsuarios: () {
        abrirPantalla(const UsersScreen());
      },
      onConfiguracion: () {
        abrirPantalla(const ConfigurationScreen());
      },
      onPublicacion: () {
        abrirPantalla(const CreatePostScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);


    return LayoutBuilder(
      builder: (context, constraints) {
        final esEscritorio = constraints.maxWidth >= 900;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
          ),
          drawer: esEscritorio
            ? null
            : Drawer(
              child: Builder(
                builder: (drawerContext) => construirMenu(
                  drawerContext,
                  esDrawer: true,
                ),
              ),
            ),
          body: Row(
            children: [
              if (esEscritorio)
                SizedBox(
                  width: 240,
                  child: construirMenu(context)
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumen general',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListenableBuilder(
                        listenable: settings,
                        builder:(context, child) {
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  leading: Icon(
                                    settings.notificaciones ? Icons.notifications_active : Icons.notifications_off,
                                  ),
                                  title: const Text('Notificaciones'),
                                  subtitle: Text(
                                    settings.notificaciones ? 'Activadas' : 'Desactivadas',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Card(
                                child: ListTile(
                                  leading: Icon(
                                    settings.modoOscuro ? Icons.dark_mode : Icons.light_mode,
                                  ),
                                  title: const Text('Modo Oscuro'),
                                  subtitle: Text(
                                    settings.modoOscuro ? 'Activado' : 'Desactivado',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      construirContenido(),
                      const SizedBox(height: 24),
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Actividad reciente',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 12),
                              Text('Nuevo usuario registrado'),
                              SizedBox(height: 8),
                              Text('Publicación creada'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
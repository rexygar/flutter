import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendeme_agency_front/state/app_settings.dart';

class ConfigurationScreen extends ConsumerWidget{

  const ConfigurationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Notificaciones'),
            subtitle: const Text(
              'Activar o desactivar notificaciones',
            ),
            value: settings.notificaciones,
            onChanged: (value) {
              ref
                .read(appSettingsProvider.notifier)
                .cambiarNotificaciones(value);
            },
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Modo oscuro'),
            subtitle: const Text(
              'Activar o desactivar el modo oscuro',
            ),
            value: settings.modoOscuro,
            onChanged:(value) {
              ref
                .read(appSettingsProvider.notifier)
                .cambiarModoOscuro(value);
            },
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Mostrar Estadisticas'),
            subtitle: const Text(
              'Mostrar u ocultar las estadisticas',
            ),
            value: settings.mostrarEstadistica,
            onChanged: (value) {
              ref
                .read(appSettingsProvider.notifier)
                .mostrarEstadistica(value);
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Versión'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
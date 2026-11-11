import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingsState {
  final bool notificaciones;
  final bool modoOscuro;
  final bool mostrarEstadistica;

  const AppSettingsState({
    this.notificaciones = true,
    this.modoOscuro = false,
    this.mostrarEstadistica = true,
  });

  AppSettingsState copyWith({
    bool? notificaciones,
    bool? modoOscuro,
    bool? mostrarEstadistica,
  }) {
    return AppSettingsState(
      notificaciones: 
        notificaciones ?? this.notificaciones,
      modoOscuro: 
        modoOscuro ?? this.modoOscuro,
      mostrarEstadistica: 
        mostrarEstadistica ?? this.mostrarEstadistica,
    );
  }
}

class AppSettings extends Notifier<AppSettingsState>{
  @override
  AppSettingsState build() {
    return const AppSettingsState();
  }

  void cambiarNotificaciones(bool valor) {
    if (state.notificaciones == valor) return;

    state = state.copyWith(
      notificaciones: valor,
    );
  }

  void cambiarModoOscuro(bool valor) {
    if (state.modoOscuro == valor) return;

    state = state.copyWith(
      modoOscuro: valor,
    );
  }

  void mostrarEstadistica(bool valor) {
    if (state.mostrarEstadistica == valor) return;

    state = state.copyWith(
      mostrarEstadistica: valor
    );
  }
}

final appSettingsProvider = NotifierProvider<AppSettings, AppSettingsState>(
  AppSettings.new,
);
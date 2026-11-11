import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingsState {
  final bool notificaciones;
  final bool modoOscuro;

  const AppSettingsState({
    this.notificaciones = true,
    this.modoOscuro = false,
  });

  AppSettingsState copyWith({
    bool? notificaciones,
    bool? modoOscuro,
  }) {
    return AppSettingsState(
      notificaciones: 
        notificaciones ?? this.notificaciones,
      modoOscuro: 
        modoOscuro ?? this.modoOscuro,
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
}

final appSettingsProvider = NotifierProvider<AppSettings, AppSettingsState>(
  AppSettings.new,
);
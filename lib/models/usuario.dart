class Usuario {
  final int id;
  final String username;
  final String nombre;
  final String correo;

  const Usuario({
    required this.id,
    required this.username,
    required this.nombre,
    required this.correo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      username: json['username'] as String,
      nombre: json['name'] as String,
      correo: json['email'] as String,
    );
  }
}
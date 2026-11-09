class Publicacion {
  final int? id;
  final int userId;
  final String titulo;
  final String contenido;

  const Publicacion({
    this.id,
    required this.userId,
    required this.titulo,
    required this.contenido,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': titulo,
      'body': contenido,
    };
  }

  factory Publicacion.fromJson(Map<String, dynamic> json) {
    return Publicacion(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      titulo: json['title'] as String,
      contenido: json['body'] as String,
    );
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendeme_agency_front/models/publicacion.dart';

class PublicacionService {
  Future<Publicacion> crearPublicacion(
    Publicacion publicacion,
  ) async {
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts',
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(publicacion.toJson()),
    ).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Error al crear publicación: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Publicacion.fromJson(json);
  }
}
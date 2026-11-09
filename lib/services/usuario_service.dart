import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vendeme_agency_front/models/usuario.dart';

class UsuarioService {
  Future<List<Usuario>> obtenerUsuarios() async {
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/users',
    );

    final response = await http.get(url).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error HTTP: ${response.statusCode}'
      );
    }

    final List<dynamic> datos = jsonDecode(
      response.body,
    );

    return datos.map((json) {
      return Usuario.fromJson(
        json as Map<String, dynamic>,
      );
    }).toList();
  }
}
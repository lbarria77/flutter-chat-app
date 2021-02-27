import 'package:http/http.dart' as http;

import 'package:flutter_chat_app/models/usuario.dart';
import 'package:flutter_chat_app/global/environment.dart';
import 'package:flutter_chat_app/services/auth_services.dart';
import '../models/usuarios_response.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuario() async {
    try {
      final resp = await http.get('${Environment.apiUrl}/usuarios', headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
      final usuarioResponse = usuariosResponseFromJson(resp.body);

      return usuarioResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}

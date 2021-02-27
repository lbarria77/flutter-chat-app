import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth_services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_chat_app/models/usuario.dart';
import '../models/mensajes_response.dart';
import 'package:flutter_chat_app/global/environment.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get('${Environment.apiUrl}/mensajes/$usuarioID',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}

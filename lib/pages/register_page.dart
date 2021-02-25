import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helpers/mostrar_alerta.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat_app/services/auth_services.dart';

import 'package:flutter_chat_app/widgets/boton_azul.dart';
import 'package:flutter_chat_app/widgets/custom_input.dart';
import 'package:flutter_chat_app/widgets/label.dart';
import 'package:flutter_chat_app/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(titulo: 'Registro'),
                  _Form(),
                  Label(
                      ruta: 'login',
                      textTitle: 'Ya tienes una Cuenta',
                      textsubtitle: 'Inicia Sesion'),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person_outline,
            placeHolder: 'Nombre Completo',
            keyBoardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyBoardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
              icon: Icons.lock_open_outlined,
              placeHolder: 'Contraseña',
              isPassword: true,
              textController: passCtrl),
          BotonAzul(
            text: 'Crear Cuenta',
            onPressed: authService.autenticando
                ? null
                : () async {
                    print(nameCtrl.text);
                    print(emailCtrl.text);
                    print(passCtrl.text);
                    final registroOk = await authService.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());

                    if (registroOk == true) {
                      // TODO: Conectar Socket Server
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro Incorrecto', registroOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}

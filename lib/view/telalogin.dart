import 'package:bd_usuarios/model/usuario.dart';
import 'package:bd_usuarios/provider/provider_usuario.dart';
import 'package:flutter/material.dart';
import 'package:bd_usuarios/dados/banco.dart';
import 'package:provider/provider.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  var banco = Banco();
  Usuario? usuarioAutenticado;

  _autenticacao() async {
    if (controllerUsuario.text == "" || controllerSenha.text == "") {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Login e senha obrigatórios!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"))
              ],
            );
          });
    } else {
      var resultado = await banco.consultarLoginUsuario(
          controllerUsuario.text, controllerSenha.text);

      if (resultado != null) {
        Provider.of<UsuarioModel>(context, listen: false).user = resultado;
        return Navigator.pushReplacementNamed(
          context,
          "/telainicio",
        );
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Usuário ou senha incorreta!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"))
                ],
              );
            });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    banco.criarUsuarioAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controllerUsuario,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                hintText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controllerSenha,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    color: Colors.blue,
                  ),
                  hintText: "Senha",
                  border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _autenticacao();
              },
              child: const Text(
                "ENTRAR",
                style: TextStyle(
                  fontSize: 17,
                  decoration: TextDecoration.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

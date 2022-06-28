import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

import '../model/permissoes.dart';
import '../provider/permissoes.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController controllerUsuario =
      TextEditingController(text: "admin@ifto.com");
  TextEditingController controllerSenha =
      TextEditingController(text: "123456789");
  TextEditingController controllerRecuperarSenha = TextEditingController();

  bool loading = false;

  late UsuarioProvider usuarioProvider;
  late AuthProvider authProvider;
  late PermissoesModel permissoesProvider;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    permissoesProvider = Provider.of<PermissoesModel>(context, listen: false);
  }

  _recuperarSenha() {
    controllerRecuperarSenha.clear();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Recuperar senha"),
            content: TextField(
              controller: controllerRecuperarSenha,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "E-mail", hintText: "Digite seu e-mail"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: controllerRecuperarSenha.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: SingleChildScrollView(
                          child: Row(children: const [
                            Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            Text("Email de recuperação enviado!"),
                          ]),
                        ),
                      ));
                    } on FirebaseAuthException catch (e) {
                      var msg_erro = "";
                      if (e.code == "invalid-email") {
                        msg_erro == "Endereço de e-mail inválido!";
                      } else if (e.code == "user-not-found") {
                        msg_erro =
                            "Não existe um usuário correspondente para o endereço de e-mail fornecido!";
                      } else {
                        msg_erro = "Digite um e-mail cadastrado!";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(msg_erro),
                      ));
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Recuperar"))
            ],
          );
        });
  }

  _autenticacao() async {
    final String login = controllerUsuario.text;
    final String senha = controllerSenha.text;

    // final UsuarioFirebase? usuario = await usuarioProvider.consultarLoginUsuario(
    //   login,
    //   senha,
    // );
    setState(() => loading = true);
    if (controllerUsuario.text == "" || controllerSenha == "") {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Login e senha obrigatorios"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => loading = false);
                    },
                    child: const Text("ok"))
              ],
            );
          });

      // } if (usuario != null && usuario.isAdmin ==0) {
      //   authProvider.login(usuario);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text("Seja bem vindo ${usuario.nome}!"),
      //         ],
      //       ),
      //       duration: const Duration(seconds: 2),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      //   await Navigator.pushReplacementNamed(context, "/homecliente");
    } else {
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: const Text("Erro"),
      //       content: const Text("Usuário ou senha inválidos"),
      //       actions: <Widget>[
      //         ElevatedButton(
      //           child: const Text("OK"),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      try {
        final credencial = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: controllerUsuario.text, password: controllerSenha.text);
        await authProvider.login(credencial.user);
        await permissoesProvider.carregarPermissoes(authProvider.user!);
        return Navigator.pushReplacementNamed(context, "/home");
      } on FirebaseAuthException catch (e) {
        setState(() => loading = false);
        var msg_erro = "";
        if (e.code == 'user-not-found') {
          msg_erro = " nenhum usuario encontradocom esse email";
        } else if (e.code == 'wrong-password') {
          msg_erro = "Erro na senha para esse usuario";
        } else {
          msg_erro = "nenhum usuario encontrado";
        }
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(msg_erro),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("ok"))
                ],
              );
            });
      }
    }
  } // fim _autenticacao

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
              child: (loading == true)
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      "ENTRAR",
                      style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.none,
                      ),
                    ),
            ),
            TextButton(
                onPressed: () {
                  _recuperarSenha();
                },
                child: const Text("Esqueci minha senha"))
          ],
        ),
      ),
    );
  }
}

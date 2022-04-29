import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/provider_usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/dados/banco.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController controllerRecuperarSenha = TextEditingController();

  var banco = Banco();
  Usuario? usuarioAutenticado;

  _recuperarSenha(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Recuperar senha"),
          content: TextField(
            controller: controllerRecuperarSenha,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "E-mail",
              hintText: "digite seu e-mail"
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar")
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: controllerRecuperarSenha.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: SingleChildScrollView(
                        child: Row(
                          children: const [
                            Icon(Icons.email, color: Colors.white,),
                            Text("Email de recuperação enviado!"),
                          ],
                        ),
                      )
                    )
                  );
                  Navigator.pop(context);
                },
                child: const Text("Recuperar")
            )
          ],
        );
      }
    );
  }

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
        }
      );
    } else {
      try {
        Usuario usuarioLogado = Usuario();
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: controllerUsuario.text,
            password: controllerSenha.text
        );
        // Pega os dados do usuário autenticado e passa para o Provider
        FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: controllerUsuario.text)
          .get()
          .then(
            (value) {
              value.docs.forEach(
                (usr) {
                  usuarioLogado.id = usr.id;
                  usuarioLogado.cpf = usr['cpf'];
                  usuarioLogado.nome = usr['nome'];
                  usuarioLogado.email = usr['email'];
                  usuarioLogado.login = usr['login'];
                  usuarioLogado.senha = usr['senha'];
                  usuarioLogado.avatar = usr['avatar'];
                }
              );
            }
          );

        Provider.of<UsuarioModel>(context, listen: false).user = usuarioLogado;
        return Navigator.pushReplacementNamed(
          context,
          "/telainicio",
        );
      } on FirebaseAuthException catch (e) {
        var msg_erro = "";
        if (e.code == 'user-not-found') {
          msg_erro = 'Nenhum usuário encontrado com esse e-mail.';
        } else if (e.code == 'wrong-password') {
          msg_erro = 'Erro na senha para esse usuário.';
        }else{
          msg_erro = 'Nenhum usuário econtrado!';
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
                      child: const Text("Ok"))
                ],
              );
        });
      }
    } // fim do else
  } // fim _autenticacao

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
                  Icons.email,
                  color: Colors.blue,
                ),
                hintText: "E-mail",
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
                  border: OutlineInputBorder()
              ),
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
            ),
            TextButton(
                onPressed: (){
                  _recuperarSenha();
                },
                child: Text('Esqueceu sua senha')
            )
          ],
        ),
      ),
    );
  }
}


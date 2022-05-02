import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
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
      TextEditingController(text: "admin");
  TextEditingController controllerSenha = TextEditingController(text: "123456");
  TextEditingController controllerRecuperarSenha = TextEditingController();
  late UsuarioProvider usuarioProvider;
  bool loading = false;
  Permissoes permissoes = Permissoes();

  /*carregarPermissoesUsuarioAutenticado(UsuarioFirebase user) async {
    CollectionReference usuarios =
        await FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(user.id).collection(user.cpf!).get().then((value) {
      value.docs.forEach((usr) {
        if (usr.id == 'modClientes') {
          permissoes.modClientes = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modUsuarios') {
          permissoes.modUsuarios = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
            'detalhe': usr['detalhe'],
            'permissoes': usr['permissoes'],
          };
        }
        if (usr.id == 'modFornecedores') {
          permissoes.modFornecedores = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modProdutos') {
          permissoes.modProdutos = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modVendas') {
          permissoes.modVendas = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
      });
    });
    Provider.of<PermissoesModel>(context, listen: false).permissoes =
        permissoes;
  }
  */

  carregarPermissoesUsuarioAutenticado(UsuarioFirebase user) async {
    CollectionReference usuarios =
        await FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(user.id).collection(user.cpf!).get().then((value) {
      value.docs.forEach((usr) {
        if (usr.id == 'modClientes') {
          permissoes.modClientes = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modUsuarios') {
          permissoes.modUsuarios = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
            'detalhe': usr['detalhe'],
            'permissoes': usr['permissoes'],
          };
        }
        if (usr.id == 'modFornecedores') {
          permissoes.modFornecedores = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modProdutos') {
          permissoes.modProdutos = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
        if (usr.id == 'modVendas') {
          permissoes.modVendas = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
        }
      });
    });
    Provider.of<PermissoesModel>(context, listen: false).permissoes =
        permissoes;
  }

  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
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
            content: const Text("Login e senha obrigatórios!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => loading = false);
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
        setState(() => loading = false);
        var msg_erro = "";
        if (e.code == 'user-not-found') {
          msg_erro = 'Nenhum usuário encontrado com esse e-mail.';
        } else if (e.code == 'wrong-password') {
          msg_erro = 'Erro na senha para esse usuário.';
        }else{
          msg_erro = 'Nenhum usuário encontrado!';
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
              keyboardType: TextInputType.emailAddress,
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
              child: (loading == true) ? const CircularProgressIndicator(color: Colors.white,) : const Text(
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
                child: const Text('Esqueceu sua senha')
            )
          ],
        ),
      ),
    );
  }
}

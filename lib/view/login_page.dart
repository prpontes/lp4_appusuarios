import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController controllerUsuario =
      TextEditingController(text: "admin");
  TextEditingController controllerSenha = TextEditingController(text: "123456");

  late UsuarioProvider usuarioProvider;

  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  _autenticacao() async {
    final String login = controllerUsuario.text;
    final String senha = controllerSenha.text;

    // final UsuarioFirebase? usuario = await usuarioProvider.consultarLoginUsuario(
    //   login,
    //   senha,
    // );

    if (controllerUsuario.text == ""|| controllerSenha== "" ) {
      return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: const Text("Login e senha obrigatorios"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                },
                    child: const Text("ok")
                )
              ],
            );
          });

      await Navigator.pushReplacementNamed(context, "/telainicio");
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
      try{
        UsuarioFirebase usuario = UsuarioFirebase();
        final credencial =await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: controllerUsuario.text, password: controllerSenha.text
        );
        await FirebaseFirestore.instance.collection('usuarios').where('email', isEqualTo: controllerUsuario.text)
        .get().then((value)
         {
           value.docs.forEach((usr) {
             usuario.id =usr.id;
             usuario.cpf =usr['cpf'];
             usuario.nome =usr['nome'];
             usuario.email= usr['email'];
             usuario.login= usr['login'];
             usuario.senha= usr['senha'];
             usuario.avatar= usr['avatar'];

           });
         }
        );
        Provider.of<AuthProvider>(context,listen: false).login(usuario);
        return Navigator.pushReplacementNamed(context,"/telainicio");
      }on  FirebaseAuthException catch(e){
        var msg_erro= "";
        if(e.code== 'user-not-found'){
          msg_erro= " nenhum usuario encontradocom esse email";
        }else if(e.code == 'wrong-password'){
          msg_erro= "Erro na senha para esse usuario";
        }else{
          msg_erro= "nenhum usuario encontrado";
        }
        return showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: Text(msg_erro),
                actions: [
                  TextButton(onPressed: (){
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

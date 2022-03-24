import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bd_usuarios/dados/banco.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  var banco = Banco();

  _autenticacao() async
  {
    var resultado = await banco.consultarUsuario(controllerUsuario.text, controllerSenha.text);
    print(resultado);
    if(resultado == true)
    {
      return Navigator.pushNamed(context, "/", );
    }else{
      return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text("Usuário ou senha incorreta!"),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          }
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banco.criarUsuarioAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controllerUsuario,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Usuário"
              ),
            ),
            TextField(
              controller: controllerSenha,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Senha"
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  _autenticacao();
                },
                child: Text(
                    "Ok",
                  style: TextStyle(
                    fontSize: 20,
                      decoration: TextDecoration.none,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

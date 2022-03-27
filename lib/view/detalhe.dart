import 'package:bd_usuarios/model/usuario.dart';
import 'package:flutter/material.dart';

class TelaDetalhe extends StatefulWidget {
  final Usuario usuario;

  const TelaDetalhe(this.usuario, {Key? key}) : super(key: key);

  @override
  State<TelaDetalhe> createState() => _TelaDetalheState();
}

class _TelaDetalheState extends State<TelaDetalhe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
              onPressed: (){
                  Navigator.pop(context);
              },
            ),
            bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list_outlined,)),
                  Tab(icon: Icon(Icons.settings)),
                ]
            ),
            title: const Text("Detalhe usuário"),
          ),
          body: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.usuario.avatar == "" ? Icon(Icons.account_circle, color: Colors.blue, size: 150,) : CircleAvatar(backgroundImage: NetworkImage(widget.usuario.avatar!)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Nome: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario.nome!, style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Cpf: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario.cpf!, style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("E-mail: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario.email!, style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario.login!, style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Senha: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("******", style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ],
                ),
                Text("Tab 2"),
            ]
          ),
        ),
      )
    );
  }
}

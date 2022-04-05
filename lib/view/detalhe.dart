import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';

class TelaDetalheUsuario extends StatefulWidget {
  final Usuario? usuario;

  const TelaDetalheUsuario({this.usuario, Key? key}) : super(key: key);

  @override
  State<TelaDetalheUsuario> createState() => _TelaDetalheUsuarioState();
}

class _TelaDetalheUsuarioState extends State<TelaDetalheUsuario> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
              onPressed: (){
                  Navigator.pop(context);
              },
            ),
            bottom: const TabBar(
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
                    widget.usuario!.avatar == "" ?
                    const Icon(Icons.account_circle, color: Colors.blue, size: 150,) :
                    CircleAvatar(backgroundImage: NetworkImage(widget.usuario!.avatar!)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Nome: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.nome!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Cpf: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.cpf!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("E-mail: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.email!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.login!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Senha: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("******", style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ],
                ),
                const Text("Tab 2"),
            ]
          ),
        ),
      )
    );
  }
}

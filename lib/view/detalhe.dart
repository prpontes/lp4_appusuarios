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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhe usuário"),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.white60,
              child: Row(
                children: [
                  const Text(
                    "Nome: ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    widget.usuario.nome!,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.white24,
              child: Row(
                children: [
                  const Text(
                    "Cpf: ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    widget.usuario.cpf!,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.white60,
              child: Row(
                children: [
                  const Text(
                    "E-mail: ",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    widget.usuario.email!,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

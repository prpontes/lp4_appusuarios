import 'package:flutter/material.dart';


class TelaFornecedor extends StatefulWidget {
  const TelaFornecedor({Key? key}) : super(key: key);

  @override
  State<TelaFornecedor> createState() => _TelaFornecedorState();
}

class _TelaFornecedorState extends State<TelaFornecedor> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Fornecedores"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    "/cadastrarfornecedor"
                );
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

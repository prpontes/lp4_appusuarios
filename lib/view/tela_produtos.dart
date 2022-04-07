import 'package:flutter/material.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({Key? key}) : super(key: key);

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: const Center(
        child: Text('Tela Produtos'),
      ),
    );
  }
}

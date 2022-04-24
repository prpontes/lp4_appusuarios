import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/main.dart';

class TelaVendas extends StatefulWidget {
  const TelaVendas({Key? key}) : super(key: key);

  @override
  _TelaVendasState createState() => _TelaVendasState();
}

class _TelaVendasState extends State<TelaVendas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vendas"), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.print))
      ]),
    );
  }
}

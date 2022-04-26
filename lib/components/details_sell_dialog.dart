
import 'package:flutter/material.dart';
import '../view/sales.page.dart';

class detalheVendas extends StatefulWidget {
   

   detalheVendas({ Key? key,}) : super(key: key);

  @override
  _detalheVendasState createState() => _detalheVendasState();
}

class _detalheVendasState extends State<detalheVendas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Detalhes da Venda"), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search))
      ]),
      

    );
  }
}
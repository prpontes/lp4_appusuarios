
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
       appBar: AppBar(
        title: Text("Detalhes da Venda"),
        actions: []
        ),
       
      body: Column(children: [
      
                        const Icon(
                            Icons.price_check_outlined,
                            color: Colors.blue,
                            size: 150,
                          ),
                       
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Nome do Produto: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Cliente: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                         
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Fornecedor: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        
                        ],
                      ),
                    ),
                   
      ]),

    );
  }
}
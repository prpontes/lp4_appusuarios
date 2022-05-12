import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/product/product_card.dart';
import 'package:lp4_appusuarios/model/item_venda.dart';
import 'package:lp4_appusuarios/model/sell.dart';


class DetalheVendas extends StatefulWidget {
  final Sell sell;
  const DetalheVendas({Key? key, required this.sell}) : super(key: key);

  @override
  _DetalheVendasState createState() => _DetalheVendasState();
}

class _DetalheVendasState extends State<DetalheVendas> {

 
  @override
  Widget build(BuildContext context) {
    Sell sell = widget.sell;
    
    List<ItemVenda> itensVendas = sell.items;
    return Scaffold(
        appBar: AppBar(title: Text(sell.username!), actions: [moneyValues(sell)], ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: itensVendas.length,
                  itemBuilder: (context, index) {
                    if (itensVendas.isNotEmpty == true) {
                      
                      final item = itensVendas[index];
                     return ProductCard(
                       product: item.produto!,
                       showBottomLabel: false,
                       topRightBuilder: (_) => Text("Quantidade: ${item.quantity.toString()}", style: TextStyle(color: Colors.green),),
                     );
                    } else {
                      return const Text("Nenhum Produto nesta venda! ");
                    }
                  }),
            )
          ],
        ));
  }
   double totalPrice(Sell sell) {
    return sell.items.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
  }
   Widget moneyValues(Sell sell) {
     
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: RichText(
              text: TextSpan(
                  
                  text: 'R\$${totalPrice(sell).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                    
                  ),
                  children: [
                    TextSpan(
                        text: '\nTotal Comprado',
                        style: TextStyle(
                          
                            color: Colors.grey, fontWeight: FontWeight.bold))
                  ]),
            ),
          )
        ]);
  }
}


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
        appBar: AppBar(title: Text(sell.username!), actions: []),
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
                       topRightBuilder: (_) => Text("Quantidade: ${item.quantity.toString()}"),
                     );
                    } else {
                      return const Text("Nenhum Produto nesta venda! ");
                    }
                  }),
            )
          ],
        ));
  }
}

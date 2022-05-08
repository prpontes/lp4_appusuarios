import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lp4_appusuarios/provider/sell_provider.dart';

class DetalheVendas extends StatefulWidget {
  const DetalheVendas({
    Key? key,
  }) : super(key: key);

  @override
  _DetalheVendasState createState() => _DetalheVendasState();
}

class _DetalheVendasState extends State<DetalheVendas> {
  late SellProvider sellProvider;

  @override
  void initState() {
    super.initState();
    sellProvider = Provider.of<SellProvider>(context, listen: false);
    sellProvider.listItems(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Detalhes da Venda"), actions: []),
        body: Column(
          children: <Widget>[
            Expanded(child: Consumer<SellProvider>(
                builder: (BuildContext context, value, Widget? child) {
              final itensVendas = value.itensVenda;
              return ListView.builder(
                  itemCount: itensVendas.length,
                  itemBuilder: (context, index) {
                    if (itensVendas.isNotEmpty == true) {
                      final item = itensVendas[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 200,
                        width: double.maxFinite,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 2.0,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(7),
                              child: Stack(children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: "${item.produto}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.green,
                                                            fontSize: 20),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text:
                                                                  '\n ${item.quantity}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          RichText(
                                                            textAlign:
                                                                TextAlign.left,
                                                            text: TextSpan(
                                                              text:
                                                                  '\n\$ ${item.price}',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 35,
                                                              ),
                                                              children: <
                                                                  TextSpan>[],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Text("Nenhum Produto nesta venda! ");
                    }
                  });
            }))
          ],
        ));
  }
}

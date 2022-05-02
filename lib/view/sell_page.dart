// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/main.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import '../test/sell_data.dart';
import 'package:lp4_appusuarios/provider/sell_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class TelaVendas extends StatefulWidget {
  const TelaVendas({Key? key}) : super(key: key);

  @override
  _TelaVendasState createState() => _TelaVendasState();
}

class _TelaVendasState extends State<TelaVendas> {
  late SellProvider sellProvider;

  @override
  void initState() {
    super.initState();
    sellProvider = Provider.of<SellProvider>(context, listen: false);
    sellProvider.listSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Vendas"), actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.print))
        ]),
        body: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Consumer<SellProvider>(
                builder: (BuildContext context, value, Widget? child) {
              final sales = value.sales;
              return ListView.builder(
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    if (sales.isNotEmpty == true) {
                      final sell = sales[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        height: 100,
                        width: double.maxFinite,
                        child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(7),
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Column(children: <Widget>[
                                      Row(children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.attach_money,
                                              color: Colors.primaries[Random()
                                                  .nextInt(
                                                      Colors.primaries.length)],
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                              text: sell.date!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: sell.id!.toString(),
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ])
                                    ]),
                                  ),
                                ],
                              ),
                            )),
                      );
                    } else {
                      return const Text(
                          "Nenhuma Venda realizada até o momento! ");
                    }
                  });
            }))
          ],
        )));
  }
}
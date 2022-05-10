import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../components/home_drawer_customer.dart';
import '../components/search_product_delegate.dart';

class TelaHomeCliente extends StatefulWidget {
  const TelaHomeCliente({Key? key}) : super(key: key);

  @override
  State<TelaHomeCliente> createState() => _TelaHomeClienteState();
}

class _TelaHomeClienteState extends State<TelaHomeCliente> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => productProvider.getProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const HomeCustomerDrawer(),
        appBar: AppBar(
          title: const Text("INICIO"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchProductDelegate(),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []),
        ));
  }
}

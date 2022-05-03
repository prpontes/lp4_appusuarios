import 'package:flutter/material.dart';

class DetalheVendas extends StatefulWidget {
  const DetalheVendas({
    Key? key,
  }) : super(key: key);

  @override
  _DetalheVendasState createState() => _DetalheVendasState();
}

class _DetalheVendasState extends State<DetalheVendas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes da Venda"), actions: []),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 180,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                              Image.network('https://vxcase.vteximg.com.br/arquivos/ids/267650-1000-1000/acessorios-vxcase-22379.png?v=637079860645670000'),
                              SizedBox(
                              height: 10,
                               ),
                            ])

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
  }
}

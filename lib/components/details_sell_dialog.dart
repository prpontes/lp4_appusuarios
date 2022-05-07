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
        appBar: AppBar(
            
            toolbarHeight: 80,
            title: Text("Nome do Usuário"),
            actions: [moneyValues()]
            
            ),
          
        body: Container(

          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 150,
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
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    imgProduct(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    nameProduct(),
                                    Spacer(),
                                    Amout(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[priceProduct()],
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
        ));
  }

  Widget moneyValues() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: RichText(
              text: TextSpan(
                  
                  text: '\$6091.12',
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

Widget imgProduct() {
  return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://s2.glbimg.com/QAGIEFy-ZKnxA2e7-ee-NUl7NtY=/0x0:680x680/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_08fbf48bc0524877943fe86e43087e7a/internal_photos/bs/2021/k/V/SxEBZlSZi41rYAkI5DOQ/cgbj0ga-huiaoaqraaantg8ow7g750.png680x680.jpg"),
        ),
      ));
}

Widget Amout() {
  return Align(
    alignment: Alignment.topRight,
    child: RichText(
      text: TextSpan(
        text: 'Quantidade:',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18),
        children: <TextSpan>[
        TextSpan(
          
            text: ' 1',
            style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    ),
  ),
);
}

Widget nameProduct() {
  return Align(
    alignment: Alignment.centerLeft,
    child: RichText(
      text: TextSpan(
        text: 'Smartphone',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
    ),
  );
}

Widget priceProduct() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '\n\$1.279',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

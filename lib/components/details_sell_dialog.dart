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
          title: Text("Nome do Usuário"), 
          actions: [
            
          ]),
        
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
                                    imagemProcuct(),
                                    SizedBox(
                                      width: 10,
                                    height: 10,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    
                                    NameProduct(),
                                    Spacer(),
                                    
                                    quantidade(),
                                    SizedBox(
                                      width: 10,
                                    ),
                
                                  ],
                                ),
                                Row(
                                  children: <Widget>[priceProduct()],
                                ),
                                
                                
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

  Widget imagemProcuct() {
   return Padding(
     padding: const EdgeInsets.only(left: 15.0),
     child: Align(
         alignment: Alignment.centerLeft,
         
         
   ));
 }

  
  Widget quantidade() {
    return Align(
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
          text: '\n+1',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }
  

  Widget NameProduct() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: 'Smartphone',
          style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.black,
               fontSize: 20),
        ),
      ),
    );
  }

  Widget priceProduct() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n\$1.279',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                children: <TextSpan>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

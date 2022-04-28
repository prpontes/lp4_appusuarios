import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/main.dart';
import '../test/sell_data.dart';
import '../components/details_sell_dialog.dart';


class TelaVendas extends StatefulWidget {
  
  
  const TelaVendas({Key? key}) : super(key: key);

  @override
  _TelaVendasState createState() => _TelaVendasState();
}


class _TelaVendasState extends State<TelaVendas> {
  var sellData = SellData.getData;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vendas"), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.print))
      ]),
      body: Container(

        child: GestureDetector(
          onTap: (){
             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                      detalheVendas(
                                  
                                ),
                                fullscreenDialog: true,
                              ),
                            );
          },

        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: sellData.length,
                itemBuilder:(context, index) {
                  return Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 100,
                      width:double.maxFinite,
                        child: Card(
                        elevation: 5,
                        child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Stack(
                        children: <Widget>[
                          Padding(
                          padding: const EdgeInsets.only(left:10,top:5),
                          child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                              cashIcon(sellData[index]),
                                SizedBox(
                                height: 10,
                                ),
                                sellName(sellData[index]),                        
                       ] 
                      )
                    ]
                  ),
                ),
              ],
            ),
          )
        ),
      );
                }) 
            )
          ],
        )
      )
    ),);
  }
}


Widget cashIcon(data){
  return Padding(
      padding: const EdgeInsets.only(left: 15.0),
        child: Align(
        alignment: Alignment.centerLeft,
          child: Icon(
          data['icon'],
          color: data['color'],
          size: 40,
          ),
          ),
          );
}

Widget sellName(data){
  return Align(
    alignment: Alignment.centerLeft,
    child: RichText(
      text: TextSpan(
        text: '${data['name']}',
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          color: Colors.black,
          fontSize: 20
        ),
        children: <TextSpan>[
          TextSpan(
            text: '\n ${data['id']}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )
          )
        ],
      ),
    ),
  );
}
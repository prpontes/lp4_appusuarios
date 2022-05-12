import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/components/product/config.dart';
import 'package:provider/provider.dart';

class config_page extends StatefulWidget {
  const config_page({Key? key}) : super(key: key);

  @override
  State<config_page> createState() => _config_pageState();
}

class _config_pageState extends State<config_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          ListTile(
            title: Text('Mudar de Tema'),
            trailing: Consumer<ThemeChanger>(builder: (context, value, child) {
              return Switch(
                activeColor: Theme.of(context).accentColor,
                value: value.isDark,
                onChanged: (status) {
                  value.setDarkStatus(status);
                },
              );
            }),
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class TelaTeste extends StatefulWidget {
  const TelaTeste({Key? key}) : super(key: key);

  @override
  State<TelaTeste> createState() => _TelaTesteState();
}

class _TelaTesteState extends State<TelaTeste> {
  @override
  void initState() {
    super.initState();
    Provider.of<UsuarioProvider>(context, listen: false).getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Teste'),
      ),
      body: Consumer<UsuarioProvider>(
        builder: (context, usuarioProvider, child) => ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(usuarioProvider.usuarios[index].nome!),
              subtitle: Text(usuarioProvider.usuarios[index].email!),
            );
          },
          itemCount: usuarioProvider.usuarios.length,
        ),
      ),
    );
  }
}

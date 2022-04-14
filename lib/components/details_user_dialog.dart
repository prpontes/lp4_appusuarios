import 'package:lp4_appusuarios/components/edit_user_dialog.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class DetailsUserDialog extends StatefulWidget {
  final Usuario usuario;
  const DetailsUserDialog({Key? key, required this.usuario}) : super(key: key);

  @override
  State<DetailsUserDialog> createState() => _DetailsUserDialogState();
}

class _DetailsUserDialogState extends State<DetailsUserDialog> {
  late UsuarioProvider usuarioProvider;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final Usuario usuario = widget.usuario;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(tabs: [
            Tab(
                icon: Icon(
              Icons.list_outlined,
            )),
            Tab(icon: Icon(Icons.settings)),
          ]),
          title: const Text("Detalhe usuário"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditUserDialog(
                      usuario: usuario,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                await usuarioProvider.deletarUsuario(usuario);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () async {
                      await usuarioProvider.inserirUsuario(usuario);
                    },
                  ),
                  content: const Text('Usuário deletado com sucesso!'),
                ));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                usuario.avatar == ""
                    ? const Icon(
                        Icons.account_circle,
                        color: Colors.blue,
                        size: 150,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(usuario.avatar!),
                        radius: 70),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Nome: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        usuario.nome!,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Cpf: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        usuario.cpf!,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "E-mail: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        usuario.email!,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        usuario.login!,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Senha: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "******",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Text("Tab 2"),
        ]),
      ),
    );
  }
}

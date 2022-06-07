import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lp4_appusuarios/components/details_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_user_dialog.dart';
import 'package:lp4_appusuarios/components/search_user_delegate.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

import '../model/permissoes.dart';
import '../provider/permissoes.dart';

class TelaUsuario extends StatefulWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
  late Permissoes permissoes;
  late UsuarioProvider usuarioProvider;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    //usuarioProvider.listarUsuarios(isAdmin: 1);
    usuarioProvider.listarUsuarioFirestore();
  }

  @override
  Widget build(BuildContext context) {
    permissoes = Provider.of<PermissoesModel>(context, listen: true).permissoes;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de usuários"),
          // input Search bar on changed
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchUserDelegate(),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<UsuarioProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  final usuarios = value.usuariosfirebase;
                  return ListView.builder(
                    itemCount: usuarios.length,
                    itemBuilder: (context, index) {
                      if (usuarios.isNotEmpty == true) {
                        final usuariofirebase = usuarios[index];
                        return Card(
                          child: ListTile(
                            leading: usuariofirebase.avatar == ""
                                ? const Icon(
                                    Icons.account_circle,
                                    color: Colors.blue,
                                    size: 50,
                                  )
                                : SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        usuariofirebase.avatar,
                                      ),
                                    ),
                                  ),
                            title: Text(usuariofirebase.nome!),
                            subtitle: Text(usuariofirebase.email!),
                            onTap: () {
                              if (permissoes.modUsuarios['detalhe'] == false) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "Você não tem permissão para detalhes do usuário!"),
                                ));
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailsUserDialog(
                                      usuarioFirebase: usuariofirebase,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return const Text("nenhum usuário");
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: (permissoes.modUsuarios['adicionar'] == true)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const MutateUserDialog(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: const Icon(Icons.add),
              )
            : null);
  }
}

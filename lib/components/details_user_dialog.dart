import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lp4_appusuarios/components/delete_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_customer.dialog.dart';
import 'package:lp4_appusuarios/components/mutate_user_dialog.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuarioFirebase.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

import '../model/permissoes.dart';
import '../model/usuario.dart';
import '../provider/permissoes.dart';

class DetailsUserDialog extends StatefulWidget {
  final UsuarioFirebase usuarioFirebase;
  const DetailsUserDialog({Key? key, required this.usuarioFirebase})
      : super(key: key);

  @override
  State<DetailsUserDialog> createState() => _DetailsUserDialogState();
}

class _DetailsUserDialogState extends State<DetailsUserDialog> {
  late UsuarioProvider usuarioProvider;
  late AuthProvider authProvider;
  UsuarioFirebase? usuarioFirebase;
  Permissoes? permissoesUsuarioAutenticado;
  Permissoes permissoes = Permissoes();
  bool listarUsuarios = true;
  bool pesquisarUsuarios = true;
  bool adicionarUsuarios = true;
  bool deletarUsuarios = true;
  bool editarUsuarios = true;
  bool detalheUsuarios = true;
  bool permissoesUsuarios = true;
  bool listarClientes = true;
  bool pesquisarClientes = true;
  bool adicionarClientes = true;
  bool deletarClientes = true;
  bool editarClientes = true;
  bool listarFornecedores = true;
  bool pesquisarFornecedores = true;
  bool adicionarFornecedores = true;
  bool deletarFornecedores = true;
  bool editarFornecedores = true;
  bool listarProdutos = true;
  bool pesquisarProdutos = true;
  bool adicionarProdutos = true;
  bool deletarProdutos = true;
  bool editarProdutos = true;
  bool listarVendas = true;
  bool pesquisarVendas = true;
  bool adicionarVendas = true;
  bool deletarVendas = true;
  bool editarVendas = true;

  Future<void> _definirPermissoesUsuario() async {
    permissoes.modUsuarios = {
      'listar': listarUsuarios,
      'pesquisar': pesquisarUsuarios,
      'adicionar': adicionarUsuarios,
      'deletar': deletarUsuarios,
      'editar': editarUsuarios,
      'detalhe': detalheUsuarios,
      'permissoes': permissoesUsuarios,
    };

    permissoes.modClientes = {
      'listar': listarClientes,
      'pesquisar': pesquisarClientes,
      'adicionar': adicionarClientes,
      'deletar': deletarClientes,
      'editar': editarClientes,
    };

    permissoes.modFornecedores = {
      'listar': listarFornecedores,
      'pesquisar': pesquisarFornecedores,
      'adicionar': adicionarFornecedores,
      'deletar': deletarFornecedores,
      'editar': editarFornecedores,
    };

    permissoes.modProdutos = {
      'listar': listarProdutos,
      'pesquisar': pesquisarProdutos,
      'adicionar': adicionarProdutos,
      'deletar': deletarProdutos,
      'editar': editarProdutos,
    };

    permissoes.modVendas = {
      'listar': listarVendas,
      'pesquisar': pesquisarVendas,
      'adicionar': adicionarVendas,
      'deletar': deletarVendas,
      'editar': editarVendas,
    };

    CollectionReference usuarios =
        FirebaseFirestore.instance.collection('usuarios');

    await usuarios
        .doc(usuarioFirebase!.id)
        .collection(usuarioFirebase!.cpf!)
        .doc('modClientes')
        .set(permissoes.modClientes);
    await usuarios
        .doc(usuarioFirebase!.id)
        .collection(usuarioFirebase!.cpf!)
        .doc('modUsuarios')
        .set(permissoes.modUsuarios);
    await usuarios
        .doc(usuarioFirebase!.id)
        .collection(usuarioFirebase!.cpf!)
        .doc('modFornecedores')
        .set(permissoes.modFornecedores);
    await usuarios
        .doc(usuarioFirebase!.id)
        .collection(usuarioFirebase!.cpf!)
        .doc('modProdutos')
        .set(permissoes.modProdutos);
    await usuarios
        .doc(usuarioFirebase!.id)
        .collection(usuarioFirebase!.cpf!)
        .doc('modVendas')
        .set(permissoes.modVendas);

    // Verifica se as mudanças das permissões é do usuário autenticado, se for, atualiza o provider.
    if (Provider.of<AuthProvider>(context, listen: false).user!.cpf ==
        usuarioFirebase!.cpf) {
      Provider.of<PermissoesModel>(context, listen: false).permissoes =
          permissoes;
    }
  }

  Future<void> _carregarPermissoesUsuarioFirebase() async {
    CollectionReference usuarios =
        FirebaseFirestore.instance.collection('usuarios');

    await usuarios
        .doc(usuarioFirebase!.id)
        .collection(usuarioFirebase!.cpf!)
        .get()
        .then((value) {
      value.docs.forEach((usr) {
        if (usr.id == 'modClientes') {
          permissoes.modClientes = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
          setState(() {
            adicionarClientes = usr['adicionar'];
            deletarClientes = usr['deletar'];
            editarClientes = usr['editar'];
            listarClientes = usr['listar'];
            pesquisarClientes = usr['pesquisar'];
          });
        }
        if (usr.id == 'modUsuarios') {
          permissoes.modUsuarios = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
            'detalhe': usr['detalhe'],
            'permissoes': usr['permissoes'],
          };
          setState(() {
            adicionarUsuarios = usr['adicionar'];
            deletarUsuarios = usr['deletar'];
            editarUsuarios = usr['editar'];
            listarUsuarios = usr['listar'];
            pesquisarUsuarios = usr['pesquisar'];
            detalheUsuarios = usr['detalhe'];
            permissoesUsuarios = usr['permissoes'];
          });
        }
        if (usr.id == 'modFornecedores') {
          permissoes.modFornecedores = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
          setState(() {
            adicionarFornecedores = usr['adicionar'];
            deletarFornecedores = usr['deletar'];
            editarFornecedores = usr['editar'];
            listarFornecedores = usr['listar'];
            pesquisarFornecedores = usr['pesquisar'];
          });
        }
        if (usr.id == 'modProdutos') {
          permissoes.modProdutos = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
          setState(() {
            adicionarProdutos = usr['adicionar'];
            deletarProdutos = usr['deletar'];
            editarProdutos = usr['editar'];
            listarProdutos = usr['listar'];
            pesquisarProdutos = usr['pesquisar'];
          });
        }
        if (usr.id == 'modVendas') {
          permissoes.modVendas = {
            'adicionar': usr['adicionar'],
            'deletar': usr['deletar'],
            'editar': usr['editar'],
            'listar': usr['listar'],
            'pesquisar': usr['pesquisar'],
          };
          setState(() {
            adicionarVendas = usr['adicionar'];
            deletarVendas = usr['deletar'];
            editarVendas = usr['editar'];
            listarVendas = usr['listar'];
            pesquisarVendas = usr['pesquisar'];
          });
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //usuarioFirebase =
    //ModalRoute.of(context)!.settings.arguments as UsuarioFirebase;
    usuarioFirebase = widget.usuarioFirebase;
    _carregarPermissoesUsuarioFirebase();
    permissoesUsuarioAutenticado =
        Provider.of<PermissoesModel>(context, listen: true).permissoes;
  }

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    permissoes =
        Provider.of<PermissoesModel>(context, listen: false).permissoes;
    final UsuarioFirebase user = widget.usuarioFirebase;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
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
            title: const Text("Detalhe usuarioFirebase"),
            actions: [
              (permissoesUsuarioAutenticado!.modUsuarios['editar'] == true)
                  ? IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MutateUserDialog(
                              usuario: user,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    )
                  : Text(""),
              (permissoesUsuarioAutenticado!.modUsuarios['deletar'] == true)
                  ? IconButton(
                      onPressed: () async {
                        // show alert dialog
                        final bool confirm = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => const DeleteDialog(
                            title: "Excluir usuário",
                            description:
                                "Tem certeza que deseja excluir o usuário?",
                          ),
                        );
                        if (!confirm) return;
                        if (user.login == authProvider.user?.login) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Você não pode excluir seu próprio usuário"),
                            ),
                          );
                          return;
                        }
                        Navigator.pop(context);
                        await usuarioProvider.deletarUsuarioFirebase(user);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          action: SnackBarAction(
                            label: 'Desfazer',
                            onPressed: () async {
                              await usuarioProvider.addUsuarioFirestore(user);
                            },
                          ),
                          content: const Text('Usuário deletado com sucesso!'),
                        ));
                      },
                      icon: const Icon(Icons.delete),
                    )
                  : Text("")
            ],
          ),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Consumer<UsuarioProvider>(
                builder: (context, value, child) {
                  UsuarioFirebase usuarioFirebase =
                      value.usuariosfirebase.firstWhere(
                    (usuarioFirebase) =>
                        usuarioFirebase.id == widget.usuarioFirebase.id,
                    orElse: () => UsuarioFirebase(
                      id: null,
                      login: "",
                      senha: "",
                      nome: "",
                      email: "",
                      avatar: "",
                      cpf: "",
                    ),
                  );

                  if (usuarioFirebase.id == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      usuarioFirebase.avatar == ""
                          ? const Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                              size: 150,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(usuarioFirebase.avatar),
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
                              usuarioFirebase.nome!,
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
                              usuarioFirebase.cpf!,
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
                              usuarioFirebase.email!,
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
                              usuarioFirebase.login!,
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
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         "isAdmin: ",
                      //         style: TextStyle(
                      //             fontSize: 20, fontWeight: FontWeight.bold),
                      //       ),
                      //       (usuarioFirebase.isAdmin == 1)
                      //           ? Text(
                      //               "é admin",
                      //               style: TextStyle(fontSize: 20),
                      //             )
                      //           : Text(
                      //               "não é admin",
                      //               style: TextStyle(fontSize: 20),
                      //             ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),
            Container(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.person),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Usuários",
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 110,
                                    child: Text(
                                      "Listar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: listarUsuarios,
                                        onChanged: (v) {
                                          setState(() {
                                            listarUsuarios = v;
                                            pesquisarUsuarios = v;
                                            adicionarUsuarios = v;
                                            deletarUsuarios = v;
                                            editarUsuarios = v;
                                            detalheUsuarios = v;
                                            permissoesUsuarios = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Pesquisar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: pesquisarUsuarios,
                                        onChanged: (v) {
                                          setState(() {
                                            pesquisarUsuarios = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Adicionar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: adicionarUsuarios,
                                        onChanged: (v) {
                                          setState(() {
                                            adicionarUsuarios = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 110,
                                    child: Text(
                                      "Deletar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: deletarUsuarios,
                                    onChanged: (v) {
                                      setState(() {
                                        deletarUsuarios = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 110,
                                    child: Text(
                                      "Editar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: editarUsuarios,
                                    onChanged: (v) {
                                      setState(() {
                                        editarUsuarios = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Detalhe",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: detalheUsuarios,
                                        onChanged: (v) {
                                          setState(() {
                                            detalheUsuarios = v;
                                            permissoesUsuarios = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 110,
                                  child: Text(
                                    "Permissões",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: permissoesUsuarios,
                                        onChanged: (v) {
                                          setState(() {
                                            permissoesUsuarios = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.apartment),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Clientes",
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Listar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: listarClientes,
                                        onChanged: (v) {
                                          setState(() {
                                            listarClientes = v;
                                            pesquisarClientes = v;
                                            adicionarClientes = v;
                                            deletarClientes = v;
                                            editarClientes = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Pesquisar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: pesquisarClientes,
                                        onChanged: (v) {
                                          setState(() {
                                            pesquisarClientes = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Adicionar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: adicionarClientes,
                                        onChanged: (v) {
                                          setState(() {
                                            adicionarClientes = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Deletar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: deletarClientes,
                                    onChanged: (v) {
                                      setState(() {
                                        deletarClientes = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Editar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: editarClientes,
                                    onChanged: (v) {
                                      setState(() {
                                        editarClientes = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.store),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Fornecedores",
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Listar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: listarFornecedores,
                                        onChanged: (v) {
                                          setState(() {
                                            listarFornecedores = v;
                                            pesquisarFornecedores = v;
                                            adicionarFornecedores = v;
                                            deletarFornecedores = v;
                                            editarFornecedores = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Pesquisar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: pesquisarFornecedores,
                                        onChanged: (v) {
                                          setState(() {
                                            pesquisarFornecedores = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Adicionar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: adicionarFornecedores,
                                        onChanged: (v) {
                                          setState(() {
                                            adicionarFornecedores = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Deletar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: deletarFornecedores,
                                    onChanged: (v) {
                                      setState(() {
                                        deletarFornecedores = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Editar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: editarFornecedores,
                                    onChanged: (v) {
                                      setState(() {
                                        editarFornecedores = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Produtos",
                                style: TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Listar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: listarProdutos,
                                        onChanged: (v) {
                                          setState(() {
                                            listarProdutos = v;
                                            pesquisarProdutos = v;
                                            adicionarProdutos = v;
                                            deletarProdutos = v;
                                            editarProdutos = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Pesquisar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: pesquisarProdutos,
                                        onChanged: (v) {
                                          setState(() {
                                            pesquisarProdutos = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Adicionar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Switch(
                                        value: adicionarProdutos,
                                        onChanged: (v) {
                                          setState(() {
                                            adicionarProdutos = v;
                                          });
                                          _definirPermissoesUsuario();
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Deletar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: deletarProdutos,
                                    onChanged: (v) {
                                      setState(() {
                                        deletarProdutos = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Editar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: editarProdutos,
                                    onChanged: (v) {
                                      setState(() {
                                        editarProdutos = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.reorder),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Vendas",
                              style: TextStyle(fontSize: 24),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Listar",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Switch(
                                      value: listarVendas,
                                      onChanged: (v) {
                                        setState(() {
                                          listarVendas = v;
                                          pesquisarVendas = v;
                                          adicionarVendas = v;
                                          deletarVendas = v;
                                          editarVendas = v;
                                        });
                                        _definirPermissoesUsuario();
                                      }),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Pesquisar",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Switch(
                                      value: pesquisarVendas,
                                      onChanged: (v) {
                                        setState(() {
                                          pesquisarVendas = v;
                                        });
                                        _definirPermissoesUsuario();
                                      }),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  "Adicionar",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Switch(
                                      value: adicionarVendas,
                                      onChanged: (v) {
                                        setState(() {
                                          adicionarVendas = v;
                                        });
                                        _definirPermissoesUsuario();
                                      }),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Deletar",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              Switch(
                                  value: deletarVendas,
                                  onChanged: (v) {
                                    setState(() {
                                      deletarVendas = v;
                                    });
                                    _definirPermissoesUsuario();
                                  })
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Editar",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Switch(
                                    value: editarVendas,
                                    onChanged: (v) {
                                      setState(() {
                                        editarVendas = v;
                                      });
                                      _definirPermissoesUsuario();
                                    })
                              ])
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}

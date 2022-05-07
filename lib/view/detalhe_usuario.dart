import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lp4_appusuarios/model/permissoes.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/provider_permissoes.dart';
import 'package:lp4_appusuarios/provider/provider_usuario.dart';
import 'package:provider/provider.dart';

class TelaDetalheUsuario extends StatefulWidget {

  const TelaDetalheUsuario({Key? key}) : super(key: key);

  @override
  State<TelaDetalheUsuario> createState() => _TelaDetalheUsuarioState();
}

class _TelaDetalheUsuarioState extends State<TelaDetalheUsuario> {

  Usuario? usuario;
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

    permissoes.modUsuarios =
    {
      'listar'  : listarUsuarios,
      'pesquisar' : pesquisarUsuarios,
      'adicionar' : adicionarUsuarios,
      'deletar' : deletarUsuarios,
      'editar' : editarUsuarios,
      'detalhe' : detalheUsuarios,
      'permissoes' : permissoesUsuarios,
    };

    permissoes.modClientes =
    {
      'listar'  : listarClientes,
      'pesquisar' : pesquisarClientes,
      'adicionar' : adicionarClientes,
      'deletar' : deletarClientes,
      'editar' : editarClientes,
    };

    permissoes.modFornecedores =
    {
      'listar'  : listarFornecedores,
      'pesquisar' : pesquisarFornecedores,
      'adicionar' : adicionarFornecedores,
      'deletar' : deletarFornecedores,
      'editar' : editarFornecedores,
    };

    permissoes.modProdutos =
    {
      'listar'  : listarProdutos,
      'pesquisar' : pesquisarProdutos,
      'adicionar' : adicionarProdutos,
      'deletar' : deletarProdutos,
      'editar' : editarProdutos,
    };

    permissoes.modVendas =
    {
      'listar'  : listarVendas,
      'pesquisar' : pesquisarVendas,
      'adicionar' : adicionarVendas,
      'deletar' : deletarVendas,
      'editar' : editarVendas,
    };

    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(usuario!.id).collection(usuario!.cpf!).doc('modClientes').set(permissoes.modClientes);
    await usuarios.doc(usuario!.id).collection(usuario!.cpf!).doc('modUsuarios').set(permissoes.modUsuarios);
    await usuarios.doc(usuario!.id).collection(usuario!.cpf!).doc('modFornecedores').set(permissoes.modFornecedores);
    await usuarios.doc(usuario!.id).collection(usuario!.cpf!).doc('modProdutos').set(permissoes.modProdutos);
    await usuarios.doc(usuario!.id).collection(usuario!.cpf!).doc('modVendas').set(permissoes.modVendas);

    // Verifica se as mudanças das permissões é do usuário autenticado, se for, atualiza o provider.
    if(Provider.of<UsuarioModel>(context, listen: false).user.cpf == usuario!.cpf) {
      Provider
          .of<PermissoesModel>(context, listen: false)
          .permissoes = permissoes;
    }
  }

  Future<void> _carregarPermissoesUsuario() async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(usuario!.id).collection(usuario!.cpf!).get().then(
            (value) {
          value.docs.forEach(
                  (usr) {
                if(usr.id == 'modClientes') {
                  permissoes.modClientes = {
                    'adicionar' : usr['adicionar'],
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                  setState(() {
                    adicionarClientes = usr['adicionar'];
                    deletarClientes = usr['deletar'];
                    editarClientes = usr['editar'];
                    listarClientes = usr['listar'];
                    pesquisarClientes = usr['pesquisar'];
                  });
                }
                if(usr.id == 'modUsuarios') {
                  permissoes.modUsuarios = {
                    'adicionar' : usr['adicionar'],
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                  setState(() {
                    adicionarUsuarios = usr['adicionar'];
                    deletarUsuarios = usr['deletar'];
                    editarUsuarios = usr['editar'];
                    listarUsuarios = usr['listar'];
                    pesquisarUsuarios = usr['pesquisar'];
                  });
                }
                if(usr.id == 'modFornecedores') {
                  permissoes.modFornecedores = {
                    'adicionar' : usr['adicionar'],
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                  setState(() {
                    adicionarFornecedores = usr['adicionar'];
                    deletarFornecedores = usr['deletar'];
                    editarFornecedores = usr['editar'];
                    listarFornecedores = usr['listar'];
                    pesquisarFornecedores = usr['pesquisar'];
                  });
                }
                if(usr.id == 'modProdutos') {
                  permissoes.modProdutos = {
                    'adicionar' : usr['adicionar'],
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                  setState(() {
                    adicionarProdutos = usr['adicionar'];
                    deletarProdutos = usr['deletar'];
                    editarProdutos = usr['editar'];
                    listarProdutos = usr['listar'];
                    pesquisarProdutos = usr['pesquisar'];
                  });
                }
                if(usr.id == 'modVendas') {
                  permissoes.modVendas = {
                    'adicionar' : usr['adicionar'],
                    'deletar' : usr['deletar'],
                    'editar' : usr['editar'],
                    'listar' : usr['listar'],
                    'pesquisar' : usr['pesquisar'],
                  };
                  setState(() {
                    adicionarVendas = usr['adicionar'];
                    deletarVendas = usr['deletar'];
                    editarVendas = usr['editar'];
                    listarVendas = usr['listar'];
                    pesquisarVendas = usr['pesquisar'];
                  });
                }
              }
          );
        }
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usuario = ModalRoute.of(context)!.settings.arguments as Usuario;
    _carregarPermissoesUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
              onPressed: (){
                  Navigator.pop(context);
              },
            ),
            bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list_outlined,)),
                  Tab(icon: Icon(Icons.settings)),
                ]
            ),
            title: const Text("Detalhe usuário"),
          ),
          body: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      usuario!.avatar == "" ?
                      const Icon(Icons.account_circle, color: Colors.blue, size: 150,) :
                      CircleAvatar(backgroundImage: NetworkImage(usuario!.avatar!), radius: 70),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Nome: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(usuario!.nome!, style: const TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Cpf: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(usuario!.cpf!, style: const TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("E-mail: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(usuario!.email!, style: const TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Login: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(usuario!.login!, style: const TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Senha: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text("******", style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                    ],
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
                                    SizedBox(width: 10,),
                                    Text("Usuários",
                                      style: TextStyle(
                                        fontSize: 24,
                                        //fontWeight: FontWeight.bold
                                      ),
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
                                        child: Text("Listar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: listarUsuarios,
                                              onChanged: (v){
                                                setState(() {
                                                  listarUsuarios = v;
                                                  pesquisarUsuarios = v;
                                                  adicionarUsuarios = v;
                                                  deletarUsuarios = v;
                                                  editarUsuarios = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Pesquisar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: pesquisarUsuarios,
                                              onChanged: (v){
                                                setState(() {
                                                  pesquisarUsuarios = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Adicionar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: adicionarUsuarios,
                                              onChanged: (v){
                                                setState(() {
                                                  adicionarUsuarios = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                          child: Text("Deletar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: deletarUsuarios,
                                          onChanged: (v){
                                            setState(() {
                                              deletarUsuarios = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Editar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: editarUsuarios,
                                          onChanged: (v){
                                            setState(() {
                                              editarUsuarios = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
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
                                    SizedBox(width: 10,),
                                    Text("Clientes",
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
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
                                        child: Text("Listar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: listarClientes,
                                              onChanged: (v){
                                                setState(() {
                                                  listarClientes = v;
                                                  pesquisarClientes = v;
                                                  adicionarClientes = v;
                                                  deletarClientes = v;
                                                  editarClientes = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Pesquisar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: pesquisarClientes,
                                              onChanged: (v){
                                                setState(() {
                                                  pesquisarClientes = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Adicionar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: adicionarClientes,
                                              onChanged: (v){
                                                setState(() {
                                                  adicionarClientes = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Deletar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: deletarClientes,
                                          onChanged: (v){
                                            setState(() {
                                              deletarClientes = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Editar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: editarClientes,
                                          onChanged: (v){
                                            setState(() {
                                              editarClientes = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
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
                                    Icon(Icons.store),
                                    SizedBox(width: 10,),
                                    Text("Fornecedores",
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
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
                                        child: Text("Listar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: listarFornecedores,
                                              onChanged: (v){
                                                setState(() {
                                                  listarFornecedores = v;
                                                  pesquisarFornecedores = v;
                                                  adicionarFornecedores = v;
                                                  deletarFornecedores = v;
                                                  editarFornecedores = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Pesquisar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: pesquisarFornecedores,
                                              onChanged: (v){
                                                setState(() {
                                                  pesquisarFornecedores = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Adicionar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: adicionarFornecedores,
                                              onChanged: (v){
                                                setState(() {
                                                  adicionarFornecedores = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Deletar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: deletarFornecedores,
                                          onChanged: (v){
                                            setState(() {
                                              deletarFornecedores = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Editar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: editarFornecedores,
                                          onChanged: (v){
                                            setState(() {
                                              editarFornecedores = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
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
                                    Icon(Icons.add),
                                    SizedBox(width: 10,),
                                    Text("Produtos",
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
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
                                        child: Text("Listar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: listarProdutos,
                                              onChanged: (v){
                                                setState(() {
                                                  listarProdutos = v;
                                                  pesquisarProdutos = v;
                                                  adicionarProdutos = v;
                                                  deletarProdutos = v;
                                                  editarProdutos = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Pesquisar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: pesquisarProdutos,
                                              onChanged: (v){
                                                setState(() {
                                                  pesquisarProdutos = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Adicionar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: adicionarProdutos,
                                              onChanged: (v){
                                                setState(() {
                                                  adicionarProdutos = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Deletar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: deletarProdutos,
                                          onChanged: (v){
                                            setState(() {
                                              deletarProdutos = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Editar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: editarProdutos,
                                          onChanged: (v){
                                            setState(() {
                                              editarProdutos = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
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
                                    Icon(Icons.reorder),
                                    SizedBox(width: 10,),
                                    Text("Vendas",
                                      style: TextStyle(
                                          fontSize: 24
                                      ),
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
                                        child: Text("Listar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: listarVendas,
                                              onChanged: (v){
                                                setState(() {
                                                  listarVendas = v;
                                                  pesquisarVendas = v;
                                                  adicionarVendas = v;
                                                  deletarVendas = v;
                                                  editarVendas = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Pesquisar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: pesquisarVendas,
                                              onChanged: (v){
                                                setState(() {
                                                  pesquisarVendas = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Adicionar",
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Switch(
                                              value: adicionarVendas,
                                              onChanged: (v){
                                                setState(() {
                                                  adicionarVendas = v;
                                                });
                                                _definirPermissoesUsuario();
                                              }
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Deletar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: deletarVendas,
                                          onChanged: (v){
                                            setState(() {
                                              deletarVendas = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                          width: 100,
                                          child: Text("Editar",
                                            style: TextStyle(
                                                fontSize: 20
                                            ),
                                          )
                                      ),
                                      Switch(
                                          value: editarVendas,
                                          onChanged: (v){
                                            setState(() {
                                              editarVendas = v;
                                            });
                                            _definirPermissoesUsuario();
                                          }
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ]
          ),
        ),
      )
    );
  }
}

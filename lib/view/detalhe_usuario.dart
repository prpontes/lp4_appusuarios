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
  Permissoes? permissoes;
  bool listarUsuarios = true;
  bool pesquisarUsuarios = true;
  bool adicionarUsuarios = true;
  bool deletarUsuarios = true;
  bool editarUsuarios = true;
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

  @override
  Widget build(BuildContext context) {

    usuario = ModalRoute.of(context)!.settings.arguments as Usuario;
    //Provider.of<PermissoesModel>(context).user = usuario!;
   // permissoes = Provider.of<PermissoesModel>(context).permissoes;

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

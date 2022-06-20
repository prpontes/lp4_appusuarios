import 'package:firebase_auth/firebase_auth.dart';
import 'package:lp4_appusuarios/model/permissoes.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/provider_permissoes.dart';
import 'package:lp4_appusuarios/provider/provider_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaUsuario extends StatefulWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  TextEditingController controllerAddCpfUsuario = TextEditingController();
  TextEditingController controllerAddNomeUsuario = TextEditingController();
  TextEditingController controllerAddEmailUsuario = TextEditingController();
  TextEditingController controllerAddLoginUsuario = TextEditingController();
  TextEditingController controllerAddSenhaUsuario = TextEditingController();
  TextEditingController controllerAddAvatarUsuario = TextEditingController();

  TextEditingController controllerEditarCpfUsuario = TextEditingController();
  TextEditingController controllerEditarNomeUsuario = TextEditingController();
  TextEditingController controllerEditarEmailUsuario = TextEditingController();
  TextEditingController controllerEditarLoginUsuario = TextEditingController();
  TextEditingController controllerEditarSenhaUsuario = TextEditingController();
  TextEditingController controllerEditarAvatarUsuario = TextEditingController();
  TextEditingController controllerBuscaUsuario = TextEditingController();

  List<Usuario> usuarios = [];
  Usuario? usuarioAutenticado;
  bool loading = true;
  late Permissoes permissoes;
  final GlobalKey<FormState> _formKeyAddUsuario = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyEditUsuario = GlobalKey<FormState>();

  _addAuthUsuario(email, password) async {
    try{
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    }on FirebaseAuthException catch (e){
      var msg_erro = '';
      if(e.code == 'weak-password'){
        msg_erro = 'A senha é muita fraca!';
      }else if(e.code == 'email-already-in-use'){
        msg_erro = 'A conta já existe para esse e-mail!';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(msg_erro)
        )
      );
    }
  }

  _deletarUserAuth()
  {
    final user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  _addUsuarioFirestore(Usuario u) async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.add(
      {
        'avatar' : u.avatar,
        'cpf' : u.cpf,
        'email' : u.email,
        'login' : u.login,
        'nome' : u.nome,
        'senha' : u.senha
      }
    ).then((value) {
      value.collection(u.cpf!).doc("modClientes").set({
        'adicionar' : true,
        'deletar' : true,
        'editar' : true,
        'listar' : true,
        'pesquisar' : true,
      });
      value.collection(u.cpf!).doc("modUsuarios").set({
        'adicionar' : true,
        'deletar' : true,
        'editar' : true,
        'listar' : true,
        'pesquisar' : true,
        'detalhe' : true,
        'permissoes' : true,
      });
      value.collection(u.cpf!).doc("modFornecedores").set({
        'adicionar' : true,
        'deletar' : true,
        'editar' : true,
        'listar' : true,
        'pesquisar' : true,
      });
      value.collection(u.cpf!).doc("modProdutos").set({
        'adicionar' : true,
        'deletar' : true,
        'editar' : true,
        'listar' : true,
        'pesquisar' : true,
      });
      value.collection(u.cpf!).doc("modVendas").set({
        'adicionar' : true,
        'deletar' : true,
        'editar' : true,
        'listar' : true,
        'pesquisar' : true,
      });
    });
    //.catchError((error) => print("Falha ao adiconar usuário no firestore: $error"));
  }

  _listarUsuariosFirestore() async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    if(this.usuarios.isNotEmpty)
      this.usuarios.clear();

    await usuarios.orderBy('nome').get().then(
      (value) {
        value.docs.forEach(
          (usr) {
            this.usuarios.add(
              Usuario(
                id: usr.id,
                cpf: usr['cpf'],
                nome: usr['nome'],
                email: usr['email'],
                login: usr['login'],
                senha: usr['senha'],
                avatar: usr['avatar'],
              )
            );
          }
        );
      }
    );
    setState(() {
      this.usuarios;
      loading = false;
    });
  }

  _editarUsuarioFirestore(String id, String cpf, String nome, String email, String login,
      String senha, String avatar) async {

    var editUsuario = Usuario(
      id: id,
      cpf: cpf,
      nome: nome,
      email: email,
      login: login,
      senha: senha,
      avatar: avatar,
    );
    
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');
    // atualiza e-mail e senha do serviço de autenticação. 
    final user = FirebaseAuth.instance.currentUser;
    await user!.updateEmail(email);
    await user.updatePassword(senha);

    // atualiza as informações da coleção usuarios do serviço Firestore
    await usuarios.doc(id).update(
      {
        "cpf": cpf,
        "nome": nome,
        "email": email,
        "login": login,
        "senha": senha,
        "avatar": avatar,
      }
    );
    await _listarUsuariosFirestore();

    if (usuarioAutenticado!.id! == id) {
      Provider.of<UsuarioModel>(context, listen: false).user = editUsuario;
    }
  }

  _deletarUsuarioFirestore(String id) async {
    CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

    await usuarios.doc(id).delete();
    await _listarUsuariosFirestore();
  }

  Future<void> _listarUsuarios() async {
    
    setState(() {
      usuarios;
    });
  }

  Future<void> _deletarUsuario(String i) async {
    _listarUsuarios();
  }

  _editarUsuario(String id, String cpf, String nome, String email, String login,
      String senha, String avatar) async {
    var editUsuario = Usuario(
      id: id,
      cpf: cpf,
      nome: nome,
      email: email,
      login: login,
      senha: senha,
      avatar: avatar,
    );

    if (usuarioAutenticado!.id! == id) {
      Provider.of<UsuarioModel>(context, listen: false).user = editUsuario;
    }

    await _listarUsuarios();
  }

  _buscarUsuario(String busca) async {
    await _listarUsuarios();
    List<Usuario> temp = [];

    if (busca == "") {
      _listarUsuarios();
    } else {
      for (var e in usuarios) {
        if (e.nome!.contains(busca) ||
            e.email == busca ||
            e.cpf == busca ||
            e.login == busca) {
          temp.add(Usuario(
            id: e.id,
            cpf: e.cpf,
            nome: e.nome,
            email: e.email,
            login: e.login,
            senha: e.senha,
            avatar: e.avatar,
          ));
        } // fim do if
      } // fim do for

      setState(() {
        usuarios = temp;
      });
    } // fim do else
  }

  _formularioBusca() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Buscar usuário"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controllerBuscaUsuario,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: "digite o termo para buscar",
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar")),
                ElevatedButton(
                    onPressed: () {
                      var str = controllerBuscaUsuario.text;
                      _buscarUsuario(str);
                      controllerBuscaUsuario.clear();
                      Navigator.pop(context);
                    },
                    child: const Text("Buscar"))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    //_listarUsuarios();
    _listarUsuariosFirestore();
  }

  @override
  Widget build(BuildContext context) {
    usuarioAutenticado = Provider.of<UsuarioModel>(context, listen: true).user;
    permissoes = Provider.of<PermissoesModel>(context, listen: true).permissoes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de usuários"),
        actions: [
          IconButton(
              onPressed: () {
                _listarUsuariosFirestore();
              },
              icon: const Icon(Icons.list)),
          (permissoes.modUsuarios['pesquisar'] == true)?
          IconButton(
              onPressed: () {
                _formularioBusca();
              },
              icon: const Icon(Icons.search))
          : Text(""),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (loading == true) ? const Center(child: CircularProgressIndicator()) :
          Expanded(
            child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  if (usuarios.isNotEmpty == true) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          if(permissoes.modUsuarios['detalhe'] == false){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Você não tem permissão para detalhes do usuário!")
                              )
                            );
                          }else {
                            Navigator.pushNamed(
                                context,
                                "/detalheusuario",
                                arguments: Usuario(
                                    id: usuarios[index].id,
                                    cpf: usuarios[index].cpf,
                                    nome: usuarios[index].nome,
                                    email: usuarios[index].email,
                                    login: usuarios[index].login,
                                    senha: usuarios[index].senha,
                                    avatar: usuarios[index].avatar
                                )
                            );
                          }
                        },
                        leading: usuarios[index].avatar == ""
                            ? const Icon(
                                Icons.account_circle,
                                color: Colors.blue,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(
                                        usuarios[index].avatar!,
                                    ),
                                onBackgroundImageError: (exception, stacktrace){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          action: SnackBarAction(
                                            label: "Fechar",
                                            onPressed: (){},
                                          ),
                                          backgroundColor: Colors.yellow,
                                          content: Text("Aviso: avatar do usuário ${usuarios[index].nome} não encontrado!",
                                            style: const TextStyle(
                                              color: Colors.black
                                            ),
                                          )
                                      )
                                  );
                                },
                              ),
                        title: Text(usuarios[index].nome!),
                        subtitle: Text(usuarios[index].email!),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              (permissoes.modUsuarios['editar'] == true) ?
                              IconButton(
                                onPressed: () {
                                  controllerEditarCpfUsuario.text =
                                  usuarios[index].cpf!;
                                  controllerEditarNomeUsuario.text =
                                  usuarios[index].nome!;
                                  controllerEditarEmailUsuario.text =
                                  usuarios[index].email!;
                                  controllerEditarLoginUsuario.text =
                                  usuarios[index].login!;
                                  controllerEditarSenhaUsuario.text =
                                  usuarios[index].senha!;
                                  controllerEditarAvatarUsuario.text =
                                  usuarios[index].avatar!;

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Editar Usuário"),
                                          content: Form(
                                            key: _formKeyEditUsuario,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize
                                                    .min,
                                                children: [
                                                  TextFormField(
                                                    keyboardType:
                                                    TextInputType.number,
                                                    decoration:
                                                    const InputDecoration(
                                                        labelText: "Cpf",
                                                        hintText: "digite um cpf"),
                                                    controller:
                                                    controllerEditarCpfUsuario,
                                                    validator: (campoCpf) {
                                                      if (campoCpf == null ||
                                                          campoCpf.isEmpty) {
                                                        return "Digite um cpf!";
                                                      }
                                                      if (CPFValidator
                                                          .isValid(
                                                          campoCpf) ==
                                                          false) {
                                                        return "Cpf digitado inválido!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                    TextInputType.text,
                                                    decoration:
                                                    const InputDecoration(
                                                        labelText: "Nome",
                                                        hintText: "digite um nome"),
                                                    controller:
                                                    controllerEditarNomeUsuario,
                                                    validator: (campoNome) {
                                                      if (campoNome == null ||
                                                          campoNome.isEmpty) {
                                                        return "Digite um nome";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    decoration:
                                                    const InputDecoration(
                                                        labelText: "E-mail",
                                                        hintText:
                                                        "digite e-mail"),
                                                    controller:
                                                    controllerEditarEmailUsuario,
                                                    validator: (campoEmail) {
                                                      if (campoEmail ==
                                                          null ||
                                                          campoEmail
                                                              .isEmpty) {
                                                        return "Digite e-mail";
                                                      }
                                                      if (EmailValidator
                                                          .validate(
                                                          campoEmail) ==
                                                          false) {
                                                        return "Digite um e-mail válido";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                    TextInputType.text,
                                                    decoration:
                                                    const InputDecoration(
                                                        labelText: "Login",
                                                        hintText:
                                                        "digite um login"),
                                                    controller:
                                                    controllerEditarLoginUsuario,
                                                    validator: (campoLogin) {
                                                      if (campoLogin ==
                                                          null ||
                                                          campoLogin
                                                              .isEmpty) {
                                                        return "Digite login";
                                                      }
                                                      if (campoLogin.length <=
                                                          3) {
                                                        return "Digite login maior que 3 caracteres";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration:
                                                    const InputDecoration(
                                                        labelText: "Senha",
                                                        hintText:
                                                        "digite uma senha"),
                                                    controller:
                                                    controllerEditarSenhaUsuario,
                                                    obscureText: true,
                                                    validator: (campoSenha) {
                                                      if (campoSenha ==
                                                          null ||
                                                          campoSenha
                                                              .isEmpty) {
                                                        return "Digite uma senha";
                                                      }
                                                      if (campoSenha.length <=
                                                          5) {
                                                        return "Digite senha maior que 5 caracteres";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                    TextInputType.text,
                                                    decoration:
                                                    const InputDecoration(
                                                        labelText: "Avatar",
                                                        hintText:
                                                        "digite url do avatar"),
                                                    controller:
                                                    controllerEditarAvatarUsuario,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                    "Cancelar")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (_formKeyEditUsuario
                                                      .currentState!
                                                      .validate()) {
                                                    _editarUsuarioFirestore(
                                                        usuarios[index].id!,
                                                        controllerEditarCpfUsuario
                                                            .text,
                                                        controllerEditarNomeUsuario
                                                            .text,
                                                        controllerEditarEmailUsuario
                                                            .text,
                                                        controllerEditarLoginUsuario
                                                            .text,
                                                        controllerEditarSenhaUsuario
                                                            .text,
                                                        controllerEditarAvatarUsuario
                                                            .text);

                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                        SnackBar(
                                                            backgroundColor: Colors
                                                                .green,
                                                            content: Text(
                                                              "Usuário ${usuarios[index]
                                                                  .nome} editado com sucesso!",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight: FontWeight
                                                                      .bold
                                                              ),
                                                            )
                                                        )
                                                    );
                                                  }
                                                },
                                                child: const Text("Salvar")),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ) : Text(""),
                              (permissoes.modUsuarios['deletar'] == true) ?
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Usuario temp = usuarios[index];
                                        return AlertDialog(
                                          content: Text(
                                              "Deseja excluir o usuário ${usuarios[index]
                                                  .nome!}?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Não")),
                                            TextButton(
                                                onPressed: () {
                                                  _deletarUsuarioFirestore(
                                                      usuarios[index].id!);
                                                  _deletarUserAuth();
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(
                                                      context).showSnackBar(
                                                      SnackBar(
                                                          action: SnackBarAction(
                                                            label: "Desfazer",
                                                            onPressed: () {
                                                              _addUsuarioFirestore(
                                                                  temp);
                                                              _listarUsuariosFirestore();
                                                            },
                                                          ),
                                                          backgroundColor: Colors
                                                              .red,
                                                          content: Text(
                                                            "Usuário ${usuarios[index]
                                                                .nome} excluído com sucesso!",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight: FontWeight
                                                                    .bold
                                                            ),
                                                          )
                                                      )
                                                  );
                                                },
                                                child: const Text("Sim")),
                                          ],
                                        );
                                      }
                                  );
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ) : Text(""),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Text("nenhum usuário");
                  }
                }),
          )
        ],
      ),
      floatingActionButton: (permissoes.modUsuarios['adicionar'] == true) ?
        FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Cadastrar Usuário"),
                  content: Form(
                    key: _formKeyAddUsuario,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: "Cpf", hintText: "digite cpf"),
                            controller: controllerAddCpfUsuario,
                            validator: (campoCpf) {
                              if (campoCpf == null || campoCpf.isEmpty) {
                                return "Digite um cpf!";
                              }
                              if (CPFValidator.isValid(campoCpf) == false) {
                                return "Cpf digitado inválido!";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: "Nome", hintText: "digite nome"),
                            controller: controllerAddNomeUsuario,
                            validator: (campoNome) {
                              if (campoNome == null || campoNome.isEmpty) {
                                return "Digite um nome";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: "E-mail",
                                hintText: "digite seu e-mail"),
                            controller: controllerAddEmailUsuario,
                            validator: (campoEmail) {
                              if (campoEmail == null || campoEmail.isEmpty) {
                                return "Digite e-mail";
                              }
                              if (EmailValidator.validate(campoEmail) ==
                                  false) {
                                return "Digite um e-mail válido";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: "Login",
                                hintText: "digite um login"),
                            controller: controllerAddLoginUsuario,
                            validator: (campoLogin) {
                              if (campoLogin == null || campoLogin.isEmpty) {
                                return "Digite login";
                              }
                              if (campoLogin.length <= 3) {
                                return "Digite login maior que 3 caracteres";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                labelText: "Senha",
                                hintText: "digite uma senha"),
                            controller: controllerAddSenhaUsuario,
                            obscureText: true,
                            validator: (campoSenha) {
                              if (campoSenha == null || campoSenha.isEmpty) {
                                return "Digite uma senha";
                              }
                              if (campoSenha.length <= 5) {
                                return "Digite senha maior que 5 caracteres";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: "Avatar", hintText: "url do avatar"),
                            controller: controllerAddAvatarUsuario,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    ElevatedButton(
                        onPressed: () {
                          //salvar novo usuario
                          if (_formKeyAddUsuario.currentState!.validate()) {
                            // bd.inserirUsuario(Usuario(
                            //   cpf: controllerAddCpfUsuario.text,
                            //   nome: controllerAddNomeUsuario.text,
                            //   email: controllerAddEmailUsuario.text,
                            //   login: controllerAddLoginUsuario.text,
                            //   senha: controllerAddSenhaUsuario.text,
                            //   avatar: controllerAddAvatarUsuario.text,
                            // ));
                            _addUsuarioFirestore(Usuario(
                              cpf: controllerAddCpfUsuario.text,
                              nome: controllerAddNomeUsuario.text,
                              email: controllerAddEmailUsuario.text,
                              login: controllerAddLoginUsuario.text,
                              senha: controllerAddSenhaUsuario.text,
                              avatar: controllerAddAvatarUsuario.text,
                            ));
                            _addAuthUsuario(controllerAddEmailUsuario.text, controllerAddSenhaUsuario.text);
                            controllerAddCpfUsuario.clear();
                            controllerAddNomeUsuario.clear();
                            controllerAddEmailUsuario.clear();
                            controllerAddLoginUsuario.clear();
                            controllerAddSenhaUsuario.clear();
                            controllerAddAvatarUsuario.clear();

                            //_listarUsuarios();
                            _listarUsuariosFirestore();

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Novo usuário criado com sucesso!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                )
                            );
                          } // fim da validação do formAddUsuario
                        },
                        child: const Text("Salvar")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ) : null
    );
  }
}

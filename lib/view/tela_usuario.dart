import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:diacritic/diacritic.dart';

class TelaUsuario extends StatefulWidget {
  const TelaUsuario({Key? key}) : super(key: key);

  @override
  State<TelaUsuario> createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
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

  final GlobalKey<FormState> _formKeyAddUsuario = GlobalKey<FormState>();

  late UsuarioProvider usuarioProvider;

  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    usuarioProvider.listarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
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
                delegate: DataSearch(usuarios: usuarioProvider.usuarios),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await usuarioProvider.listarUsuarios();
        },
        child: Column(
          children: [
            Expanded(
              child: Consumer<UsuarioProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  final usuarios = value.usuarios;
                  return ListView.builder(
                    itemCount: usuarios.length,
                    itemBuilder: (context, index) {
                      if (usuarios.isNotEmpty == true) {
                        final usuario = usuarios[index];
                        return Card(
                          child: ListTile(
                            leading: usuario.avatar == ""
                                ? const Icon(
                                    Icons.account_circle,
                                    color: Colors.blue,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      usuario.avatar!,
                                    ),
                                  ),
                            title: Text(usuario.nome!),
                            subtitle: Text(usuario.email!),
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
      ),
      floatingActionButton: FloatingActionButton(
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
                            usuarioProvider.inserirUsuario(Usuario(
                              cpf: controllerAddCpfUsuario.text,
                              nome: controllerAddNomeUsuario.text,
                              email: controllerAddEmailUsuario.text,
                              login: controllerAddLoginUsuario.text,
                              senha: controllerAddSenhaUsuario.text,
                              avatar: controllerAddAvatarUsuario.text,
                            ));
                            controllerAddCpfUsuario.clear();
                            controllerAddNomeUsuario.clear();
                            controllerAddEmailUsuario.clear();
                            controllerAddLoginUsuario.clear();
                            controllerAddSenhaUsuario.clear();
                            controllerAddAvatarUsuario.clear();

                            usuarioProvider.listarUsuarios();

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Novo usuário criado com sucesso!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )));
                          } // fim da validação do formAddUsuario
                        },
                        child: const Text("Salvar")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<Usuario> usuarios;

  DataSearch({required this.usuarios})
      : super(searchFieldLabel: "Buscar usuários");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listaUsuarios = query.isEmpty
        ? usuarios
        : usuarios
            .where(
              (p) =>
                  removeDiacritics(p.nome!.toLowerCase())
                      .contains(removeDiacritics(query.toLowerCase())) ||
                  p.email!.toLowerCase().contains(query.toLowerCase()) ||
                  p.login!.toLowerCase().contains(query.toLowerCase()) ||
                  p.cpf!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: listaUsuarios.length,
      itemBuilder: (context, index) {
        final usuario = listaUsuarios[index];
        return ListTile(
          leading: usuario.avatar == ""
              ? const Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(
                    usuario.avatar!,
                  ),
                ),
          title: Text(usuario.nome!),
          subtitle: Text(usuario.email!),
          onTap: () {
            close(context, usuario.nome!);
          },
        );
      },
    );
  }
}

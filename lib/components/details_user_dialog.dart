import 'package:lp4_appusuarios/components/delete_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_customer.dialog.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
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

  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final Usuario user = widget.usuario;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Detalhe cliente"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MutateCustomerDialog(
                      usuario: user,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () async {
                // show alert dialog
                final bool confirm = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => const DeleteDialog(
                    title: "Excluir usuário",
                    description: "Tem certeza que deseja excluir o usuário?",
                  ),
                );
                if (!confirm) return;
                if (user.login == authProvider.user?.login) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Você não pode excluir seu próprio usuário"),
                    ),
                  );
                  return;
                }
                Navigator.pop(context);
                await usuarioProvider.deletarUsuario(user);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () async {
                      await usuarioProvider.inserirUsuario(user);
                    },
                  ),
                  content: const Text('Usuário deletado com sucesso!'),
                ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Consumer<UsuarioProvider>(
            builder: (context, value, child) {
              Usuario usuario = value.usuarios.firstWhere(
                (usuario) => usuario.id == widget.usuario.id,
                orElse: () => Usuario(
                  id: null,
                  login: "",
                  senha: "",
                  nome: "",
                  email: "",
                  avatar: "",
                  cpf: "",
                ),
              );

              if (usuario.id == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  usuario.avatar == ""
                      ? const Icon(
                          Icons.account_circle,
                          color: Colors.blue,
                          size: 150,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(usuario.avatar),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "isAdmin: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        (usuario.isAdmin == 1)
                            ? Text(
                                "é admin",
                                style: TextStyle(fontSize: 20),
                              )
                            : Text(
                                "não é admin",
                                style: TextStyle(fontSize: 20),
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

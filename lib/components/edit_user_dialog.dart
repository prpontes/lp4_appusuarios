import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class EditUserDialog extends StatefulWidget {
  final Usuario usuario;
  const EditUserDialog({Key? key, required this.usuario}) : super(key: key);

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _senhaController;
  late final TextEditingController _avatarController;
  late final TextEditingController _cpfController;
  late final TextEditingController _loginController;

  late final UsuarioProvider _usuarioProvider;
  @override
  void initState() {
    super.initState();
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    _nomeController = TextEditingController(text: widget.usuario.nome);
    _emailController = TextEditingController(text: widget.usuario.email);
    _senhaController = TextEditingController(text: widget.usuario.senha);
    _avatarController = TextEditingController(text: widget.usuario.avatar);
    _cpfController = TextEditingController(text: widget.usuario.cpf);
    _loginController = TextEditingController(text: widget.usuario.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar usuário'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var novoUsuario = Usuario(
              nome: _nomeController.text,
              email: _emailController.text,
              senha: _senhaController.text,
              avatar: _avatarController.text,
              cpf: _cpfController.text,
              login: _loginController.text,
            );
            await _usuarioProvider.editarUsuario(novoUsuario);
            Navigator.of(context).pop();
          }
        },
        // icon approve
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email é obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _senhaController,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Senha é obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _avatarController,
                      decoration: const InputDecoration(
                        labelText: 'Avatar',
                      ),
                    ),
                    TextFormField(
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: 'CPF',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'CPF é obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _loginController,
                      decoration: const InputDecoration(
                        labelText: 'Login',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Login é obrigatório';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

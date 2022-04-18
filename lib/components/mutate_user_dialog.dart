import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class MutateUserDialog extends StatefulWidget {
  final Usuario? usuario;
  const MutateUserDialog({Key? key, this.usuario}) : super(key: key);

  @override
  State<MutateUserDialog> createState() => _MutateUserDialogState();
}

class _MutateUserDialogState extends State<MutateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _senhaController = TextEditingController(text: "");
  final _avatarController = TextEditingController(text: "");
  final _cpfController = TextEditingController(text: "");
  final _loginController = TextEditingController(text: "");

  late final UsuarioProvider _usuarioProvider;
  @override
  void initState() {
    super.initState();
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    if (widget.usuario != null) {
      _nomeController.text = widget.usuario!.nome!;
      _emailController.text = widget.usuario!.email!;
      _senhaController.text = widget.usuario!.senha!;
      _avatarController.text = widget.usuario!.avatar;
      _cpfController.text = widget.usuario!.cpf!;
      _loginController.text = widget.usuario!.login!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.usuario != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Editar usuário' : 'Criar usuário'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Usuario usuario = isUpdate ? widget.usuario! : Usuario();
            usuario.nome = _nomeController.text;
            usuario.email = _emailController.text;
            usuario.senha = _senhaController.text;
            usuario.avatar = _avatarController.text;
            usuario.cpf = _cpfController.text;
            usuario.login = _loginController.text;
            if (isUpdate) {
              await _usuarioProvider.editarUsuario(usuario);
            } else {
              await _usuarioProvider.inserirUsuario(usuario);
            }
            Navigator.of(context).pop();
          }
        },
        // icon approve
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                autofillHints: const [AutofillHints.name],
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: "Nome",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email é obrigatório';
                  }
                  if (EmailValidator.validate(value) == false) {
                    return "Digite um e-mail válido";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _senhaController,
                autofillHints: const [AutofillHints.password],
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: "Senha",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Senha é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _avatarController,
                decoration: const InputDecoration(
                  labelText: 'Avatar',
                  hintText: "Avatar",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: "CPF",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'CPF é obrigatório';
                  }
                  if (CPFValidator.isValid(value) == false) {
                    return "CPF digitado inválido!";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  hintText: "Login",
                  border: OutlineInputBorder(),
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
      ),
    );
  }
}

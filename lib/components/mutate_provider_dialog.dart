import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:provider/provider.dart';

import '../provider/fornecedores_provider.dart';

class MutateProviderDialog extends StatefulWidget {
  final Fornecedor? fornecedor;
  const MutateProviderDialog({Key? key, this.fornecedor}) : super(key: key);

  @override
  State<MutateProviderDialog> createState() => _MutateProviderDialogState();
}

class _MutateProviderDialogState extends State<MutateProviderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _razaoSocialController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _senhaController = TextEditingController(text: "");
  final _avatarController = TextEditingController(text: "");
  final _cnpjController = TextEditingController(text: "");
  final _loginController = TextEditingController(text: "");
  final _produtoController = TextEditingController(text: "");
  final _quantidadeController = TextEditingController(text: "");

  late final FornecedoresProvider _fornecedoresProvider;
  @override
  void initState() {
    super.initState();
    _fornecedoresProvider =
        Provider.of<FornecedoresProvider>(context, listen: false);
    if (widget.fornecedor != null) {
      _razaoSocialController.text = widget.fornecedor!.razaoSocial!;
      _emailController.text = widget.fornecedor!.email!;
      _senhaController.text = widget.fornecedor!.senha!;
      _avatarController.text = widget.fornecedor!.avatar!;
      _cnpjController.text = widget.fornecedor!.cnpj!;
      _loginController.text = widget.fornecedor!.login!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.fornecedor != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Editar fornecedor' : 'Criar fornecedor'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Fornecedor usuario = isUpdate ? widget.fornecedor! : Fornecedor();
            usuario.razaoSocial = _razaoSocialController.text;
            usuario.email = _emailController.text;
            usuario.senha = _senhaController.text;
            usuario.avatar = _avatarController.text;
            usuario.cnpj = _cnpjController.text;
            usuario.login = _loginController.text;
            if (isUpdate) {
              await _fornecedoresProvider.editarFornecedor(usuario);
            } else {
              await _fornecedoresProvider.inserirFornecedor(usuario);
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
                controller: _razaoSocialController,
                autofillHints: const [AutofillHints.name],
                decoration: const InputDecoration(
                  labelText: 'Razão Social',
                  hintText: "Razão Social",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Razão Social é obrigatório';
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
                controller: _cnpjController,
                decoration: const InputDecoration(
                  labelText: 'CNPJ',
                  hintText: "CNPJ",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'CNPJ é obrigatório';
                  }
                  if (CPFValidator.isValid(value) == false) {
                    return "CNPJ digitado inválido!";
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

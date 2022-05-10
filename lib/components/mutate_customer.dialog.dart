import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/endereco.dart';
import 'package:lp4_appusuarios/model/usuario.dart';

import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

// FUNÇÃO PARA VALIDAÇÃO DE NUMERO DE TELEFONE
String? validateMobile(String value) {
  String pattern = r'(^\(?[1-9]{2}\)? ?(?:[2-8]|9[1-9])[0-9]{3}\-?[0-9]{4}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return 'Por favor, insira um numero!';
  } else if (!regExp.hasMatch(value)) {
    return 'Por favor, coloque um telefone valido!';
  }
  return null;
}
// função para validar cep


class MutateCustomerDialog extends StatefulWidget {
  final Usuario? usuario;



  const MutateCustomerDialog({Key? key, this.usuario}) : super(key: key);


  @override
  State<MutateCustomerDialog> createState() => _MutateCustomerDialogState();



}

class _MutateCustomerDialogState extends State<MutateCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _senhaController = TextEditingController(text: "");
  final _avatarController = TextEditingController(text: "");
  final _cpfController = TextEditingController(text: "");
  final _loginController = TextEditingController(text: "");
  final _telefoneController = TextEditingController(text: "");


  final _ruaController = TextEditingController(text: "");
  final _bairroController = TextEditingController(text: "");
  final _numeroController = TextEditingController(text: "");
  final _cepController = TextEditingController(text: "");
  final _complementoController = TextEditingController(text: "");
  final _referenciaController = TextEditingController(text: "");
  final _cidadeController = TextEditingController(text: "");


  late final UsuarioProvider _usuarioProvider;

  @override
  void initState() {
    super.initState();
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    if (widget.usuario != null  ) {
      _nomeController.text = widget.usuario!.nome!;
      _emailController.text = widget.usuario!.email!;
      _senhaController.text = widget.usuario!.senha!;
      _avatarController.text = widget.usuario!.avatar;
      _cpfController.text = widget.usuario!.cpf!;
      _loginController.text = widget.usuario!.login!;
      _telefoneController.text = widget.usuario!.telefone!;

      _ruaController.text = widget.usuario!.endereco!.rua!;
      _bairroController.text = widget.usuario!.endereco!.bairro!;
      _numeroController.text = widget.usuario!.endereco!.numero!;
      _complementoController.text = widget.usuario!.endereco!.complemento!;
      _cepController.text = widget.usuario!.endereco!.cep!;
      _cidadeController.text= widget.usuario!.endereco!.cidade!;
      _referenciaController.text = widget.usuario!.endereco!.referencia!;

    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.usuario != null  ;


    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Editar cliente' : 'Criar cliente' ),

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
            usuario.telefone = _telefoneController.text;
            usuario.isAdmin = 0;



            if (isUpdate) {
              await _usuarioProvider.editarUsuario(usuario);

            } else {
              await _usuarioProvider.inserirUsuario(usuario);
              Endereco endereco= Endereco();

              endereco.rua= _ruaController.text;
              endereco.cep = _cepController.text;
              endereco.complemento = _complementoController.text;
              endereco.referencia = _referenciaController.text;
              endereco.numero = _numeroController.text;
              endereco.cidade= _cidadeController.text;
              endereco.idcliente= usuario.id;

              usuario.endereco= endereco;
              _usuarioProvider.inserirEndereco(usuario);
            }
            Navigator.of(context).pop();
          }
        },
        // icon approve
        child: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
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
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'telefone',
                  hintText: "Telefone",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Telefone é obrigatório';
                  } else {
                    return validateMobile(value);
                  }
                },
              ),
              TextFormField(
                controller: _ruaController,
                autofillHints: const [AutofillHints.addressCity],
                decoration: const InputDecoration(
                  labelText: 'Rua',
                  hintText: "Rua",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Rua é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _bairroController,
                autofillHints: const [AutofillHints.addressCity],
                decoration: const InputDecoration(
                  labelText: 'Bairro',
                  hintText: "Bairro",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bairro é obrigatório';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _cidadeController,
                autofillHints: const [AutofillHints.addressCity],
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  hintText: "Cidade",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Cidade é obrigatório';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _numeroController,
                autofillHints: const [AutofillHints.addressCity],
                decoration: const InputDecoration(
                  labelText: 'Número',
                  hintText: "Número",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Número é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _referenciaController,
                autofillHints: const [AutofillHints.addressCity],
                decoration: const InputDecoration(
                  labelText: 'Referência',
                  hintText: "Referência",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Referência é obrigatória';
                  }
                  return null;
                },

              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  hintText: "CEP",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'CEP é obrigatório';
                  }
                },

              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _complementoController,
                decoration: const InputDecoration(
                  labelText: 'Complemento',
                  hintText: "Complemento",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Complemento é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

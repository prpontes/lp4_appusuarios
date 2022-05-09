import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:provider/provider.dart';
import '../provider/fornecedores_provider.dart';

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

class MutateProviderDialog extends StatefulWidget {
  final Fornecedor? fornecedor;
  const MutateProviderDialog({Key? key, this.fornecedor}) : super(key: key);

  @override
  State<MutateProviderDialog> createState() => _MutateProviderDialogState();
}

class _MutateProviderDialogState extends State<MutateProviderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _razaoSocialController = TextEditingController(text: "");
  final _cnpjController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _telefoneController = TextEditingController(text: "");
  final _imagemController = TextEditingController(text: "");

  late final FornecedoresProvider _fornecedoresProvider;
  @override
  void initState() {
    super.initState();
    _fornecedoresProvider =
        Provider.of<FornecedoresProvider>(context, listen: false);
    if (widget.fornecedor != null) {
      _razaoSocialController.text = widget.fornecedor!.razaoSocial!;
      _cnpjController.text = widget.fornecedor!.cnpj!;
      _emailController.text = widget.fornecedor!.email!;
      _telefoneController.text = widget.fornecedor!.email!;
      _imagemController.text = widget.fornecedor!.imagem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.fornecedor != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Editar Fornecedor' : 'Criar Fornecedor'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Fornecedor fornecedor =
                isUpdate ? widget.fornecedor! : Fornecedor();
            fornecedor.razaoSocial = _razaoSocialController.text;
            fornecedor.cnpj = _cnpjController.text;
            fornecedor.email = _emailController.text;
            fornecedor.telefone = _telefoneController.text;
            fornecedor.imagem = _imagemController.text;
            if (isUpdate) {
              await _fornecedoresProvider.editarFornecedor(fornecedor);
            } else {
              await _fornecedoresProvider.inserirFornecedor(fornecedor);
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
                  if (CNPJValidator.isValid(value, false) == false) {
                    return "CNPJ digitado inválido!";
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
                controller: _telefoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: "Telefone",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Telefone é obrigatório';
                  }
                  return validateMobile(value);
                  ;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _imagemController,
                decoration: const InputDecoration(
                  labelText: 'Imagem',
                  hintText: "Imagem",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Imagem é obrigatório';
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

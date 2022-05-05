import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/endereco.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

import '../provider/endereco_provider.dart';

String?  ValidaCep(String cep)
{
  String pattern = r'[0-9]{5}-[0-9]{3}';
  RegExp regExp = RegExp(pattern);
  if (cep.isEmpty) {
    return 'Por favor, insira um Cep!';
  } else if (!regExp.hasMatch(cep)) {
    return 'Por favor, coloque um CEP valido!';
  }

}

class MutateAddressDialog extends StatefulWidget {
  final Endereco? endereco;

  const MutateAddressDialog({Key? key, this.endereco}) : super(key: key);

  @override
  State<MutateAddressDialog> createState() => _MutateAddressDialogState();
}

class _MutateAddressDialogState extends State<MutateAddressDialog> {
  final _formKey = GlobalKey<FormState>();

  // parte de endereco do cliente
  final _ruaController = TextEditingController(text: "");
  final _bairroController = TextEditingController(text: "");
  final _numeroController = TextEditingController(text: "");
  final _cepController = TextEditingController(text: "");
  final _complementoController = TextEditingController(text: "");
  final _referenciaController = TextEditingController(text: "");

  late final EnderecoProvider _enderecoProvider;
  @override
  void initState() {
    super.initState();
    _enderecoProvider = Provider.of<EnderecoProvider>(context, listen: false);
    if (widget.endereco != null) {
      _ruaController.text = widget.endereco!.rua!;
      _bairroController.text = widget.endereco!.bairro!;
      _numeroController.text = widget.endereco!.numero!;
      _complementoController.text = widget.endereco!.complemento!;
      _cepController.text = widget.endereco!.cep!;
      _referenciaController.text = widget.endereco!.referencia!;

    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.endereco != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Editar endereco' : 'Criar endereco'),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Endereco endereco = isUpdate ? widget.endereco! : Endereco();
            endereco.rua = _ruaController.text;
            endereco.bairro = _bairroController.text;
            endereco.cep = _cepController.text;
            endereco.complemento = _complementoController.text;
            endereco.referencia = _referenciaController.text;
            endereco.numero = _numeroController.text;

            if (isUpdate) {
              await _enderecoProvider.editarEndereco(endereco);
            } else {
              await _enderecoProvider.inserirEndereco(endereco);
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
                    } else {
                      return ValidaCep(value);
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

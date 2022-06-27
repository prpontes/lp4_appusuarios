import 'package:lp4_appusuarios/components/delete_user_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_address_dialog.dart';
import 'package:lp4_appusuarios/components/mutate_customer.dialog.dart';
import 'package:lp4_appusuarios/model/endereco.dart';
import 'package:lp4_appusuarios/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:lp4_appusuarios/provider/endereco_provider.dart';
import 'package:lp4_appusuarios/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

class DetailsAddressDialog extends StatefulWidget {
  final Endereco endereco;
  const DetailsAddressDialog({Key? key, required this.endereco})
      : super(key: key);

  @override
  State<DetailsAddressDialog> createState() => _DetailsAddressDialogState();
}

class _DetailsAddressDialogState extends State<DetailsAddressDialog> {
  late EnderecoProvider enderecoProvider;

  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    enderecoProvider = Provider.of<EnderecoProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final Endereco end = widget.endereco;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Detalhe endereço"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MutateAddressDialog(
                      endereco: end,
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
                    title: "Excluir endereço",
                    description: "Tem certeza que deseja excluir o endereço?",
                  ),
                );
                if (!confirm) return;

                Navigator.pop(context);
                await enderecoProvider.deletarEndereco(end);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () async {
                      await enderecoProvider.addEndereco(end);
                    },
                  ),
                  content: const Text('Endereço deletado com sucesso!'),
                ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Consumer<EnderecoProvider>(
            builder: (context, value, child) {
              Endereco endereco = value.enderecoFirebase.firstWhere(
                (endereco) => endereco.id == widget.endereco.id,
                orElse: () => Endereco(
                  id: null,
                  rua: "",
                  bairro: "",
                  cep: "",
                  complemento: "",
                  numero: "",
                  referencia: "",
                  cpfcliente: "",
                  cidade: "",
                ),
              );

              if (endereco.id == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Cidade: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          end.cidade!,
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
                          "Rua: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          end.rua!,
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
                          "CEP: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          end.cep!,
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
                          "Numero: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          end.numero!,
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
                          "Bairro: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          end.bairro!,
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
                          "Complemento: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          end.complemento!,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

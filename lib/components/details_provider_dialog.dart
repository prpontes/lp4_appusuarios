import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedorFirebase.dart';
import 'package:lp4_appusuarios/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../provider/fornecedores_provider.dart';
import 'delete_provider_dialog.dart';
import 'mutate_provider_dialog.dart';

class DetailsProviderDialog extends StatefulWidget {
  final FornecedorFirebase fornecedorFirebase;
  const DetailsProviderDialog({Key? key, required this.fornecedorFirebase})
      : super(key: key);

  @override
  State<DetailsProviderDialog> createState() => _DetailsProviderDialogState();
}

class _DetailsProviderDialogState extends State<DetailsProviderDialog> {
  late FornecedoresProvider fornecedorProvider;

  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    fornecedorProvider =
        Provider.of<FornecedoresProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final FornecedorFirebase providerFirebase = widget.fornecedorFirebase;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(tabs: [
            Tab(
                icon: Icon(
              Icons.list_outlined,
            )),
            Tab(icon: Icon(Icons.settings)),
          ]),
          title: const Text("Detalhe do Fornecedor"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MutateProviderDialog(
                      fornecedor: providerFirebase,
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
                  builder: (BuildContext context) => const DeleteProviderDialog(
                    title: "Excluir Fornecedor",
                    description: "Tem certeza que deseja excluir o fornecedor?",
                  ),
                );
                if (!confirm) return;

                Navigator.pop(context);

                await fornecedorProvider
                    .deletarFornecedorFirestore(providerFirebase);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                    label: 'Desfazer',
                    onPressed: () async {
                      await fornecedorProvider
                          .addFornecedorFirestore(providerFirebase);
                    },
                  ),
                  content: const Text('Fornecedor deletado com sucesso!'),
                ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Consumer<FornecedoresProvider>(
              builder: (context, value, child) {
                FornecedorFirebase fornecedorFirebase =
                    value.fornecedorfirebase.firstWhere(
                  (fornecedor) => fornecedor.id == widget.fornecedorFirebase.id,
                  orElse: () => FornecedorFirebase(
                    id: null,
                    cnpj: "",
                    razaoSocial: "",
                    email: "",
                    telefone: "",
                    imagem: "",
                  ),
                );

                if (fornecedorFirebase.id == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    fornecedorFirebase.imagem == ""
                        ? const Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                            size: 150,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage(fornecedorFirebase.imagem),
                            radius: 70),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Razão Social: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            fornecedorFirebase.razaoSocial!,
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
                            "CNPJ: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            CNPJValidator.format(fornecedorFirebase.cnpj!),
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
                            fornecedorFirebase.email!,
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
                            "Telefone: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            fornecedorFirebase.telefone!,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Text("Tab 2"),
        ]),
      ),
    );
  }
}

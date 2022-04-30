import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/details_provider_dialog.dart';
import '../components/mutate_provider_dialog.dart';
import '../components/search_provider_delegate.dart';
import '../provider/fornecedores_provider.dart';

class TelaFornecedor extends StatefulWidget {
  const TelaFornecedor({Key? key}) : super(key: key);

  @override
  State<TelaFornecedor> createState() => _TelaFornecedorState();
}

class _TelaFornecedorState extends State<TelaFornecedor> {
  late FornecedoresProvider fornecedorProvider;

  @override
  void initState() {
    super.initState();
    fornecedorProvider = Provider.of<FornecedoresProvider>(context, listen: false);
    fornecedorProvider.listarFornecedores();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Fornecedores"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    SearchProviderDelegate(fornecedores: fornecedorProvider.fornecedores),
              );
            },
          ),
        ],
      ),
      body: Column(
        children:[
          Expanded(
            child: Consumer<FornecedoresProvider>(
              builder:(BuildContext context, value, Widget? child){
                final fornecedores = value.fornecedores;
                return ListView.builder(
                  itemCount: fornecedores.length,
                  itemBuilder: (context, index) {
                    if(fornecedores.isNotEmpty == true){
                      final fornecedor = fornecedores[index];
                      return Card(
                        child: ListTile(
                          leading: fornecedor.imagem == ""
                              ? const Icon(
                                  Icons.account_circle,
                                  color: Colors.pink,
                                  size: 50,
                                )
                              : SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      fornecedor.imagem,
                                    ),
                                  ),
                                ),
                                title: Text(fornecedor.razaoSocial!),
                          subtitle: Text(fornecedor.email!),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailsProviderDialog(
                                  fornecedor: fornecedor,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        )
                      );
                    } else {
                      return const Text("Nenhum fornecedor encontrado!");
                    }
                  },
                );
              }
            )
            )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const MutateProviderDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

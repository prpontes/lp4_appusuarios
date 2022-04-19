import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastrarFornecedor extends StatefulWidget {
  const CadastrarFornecedor({Key? key}) : super(key: key);

  @override
  State<CadastrarFornecedor> createState() => _CadastrarFornecedorState();
}

class _CadastrarFornecedorState extends State<CadastrarFornecedor> {

  TextEditingController controllerAddRazaoSocial = TextEditingController();
  TextEditingController controllerAddTelefone = TextEditingController();
  TextEditingController controllerAddEmail = TextEditingController();
  TextEditingController controllerAddEndereco = TextEditingController();
  TextEditingController controllerAddCidade = TextEditingController();
  TextEditingController controllerAddCNPJ = TextEditingController();
  TextEditingController controllerAddProduto = TextEditingController();
  TextEditingController controllerAddDescricaoProduto = TextEditingController();

  // Future<void> _listarFornecedores() async {
  //   fornecedores = await bd.listarFornecedores();
  //
  //   setState(() {
  //     fornecedores;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Fornecedor"),
        actions: [
          IconButton(
              onPressed: () {
                //_cadastrarFornecedor();
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Column(
        children: [
          Form(
              child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: controllerAddRazaoSocial,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.text,
                  decoration:
                  const InputDecoration(
                      labelText: "Razão Social",
                      prefixIcon: Padding(
                        child: Icon(Icons.drive_file_rename_outline),
                        padding: EdgeInsets.all(5),
                      ) 
                  ),
                ), //Razão Social
                TextFormField(
                  controller: controllerAddTelefone,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.number,
                  decoration:
                  const InputDecoration(
                      labelText: "Telefone",
                      prefixIcon: Padding(
                        child: Icon(Icons.phone),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //Telefone
                TextFormField(
                  controller: controllerAddEmail,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.emailAddress,
                  decoration:
                  const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Padding(
                        child: Icon(Icons.email),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //Email
                TextFormField(
                  controller: controllerAddEndereco,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.text,
                  decoration:
                  const InputDecoration(
                      labelText: "Endereço",
                      prefixIcon: Padding(
                        child: Icon(Icons.location_on),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //Endereço
                TextFormField(
                  controller: controllerAddCidade,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.text,
                  decoration:
                  const InputDecoration(
                      labelText: "Cidade",
                      prefixIcon: Padding(
                        child: Icon(Icons.location_city),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //Cidade
                TextFormField(
                  controller: controllerAddCNPJ,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.number,
                  decoration:
                  const InputDecoration(
                      labelText: "CNPJ",
                      prefixIcon: Padding(
                        child: Icon(Icons.account_box),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //CNPJ
                TextFormField(
                  controller: controllerAddProduto,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.text,
                  decoration:
                  const InputDecoration(
                      labelText: "Produto",
                      prefixIcon: Padding(
                        child: Icon(Icons.cases_outlined),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //Produto
                TextFormField(
                  controller: controllerAddDescricaoProduto,
                  scrollPadding: const EdgeInsets.only(top: 16),
                  keyboardType:TextInputType.text,
                  decoration:
                  const InputDecoration(
                      labelText: "Descrição do Produto",
                      prefixIcon: Padding(
                        child: Icon(Icons.description),
                        padding: EdgeInsets.all(5),
                      )
                  ),
                ), //DescriçãoProduto
              ],
            ),
          ))
        ],
      ),
    );
  }
}

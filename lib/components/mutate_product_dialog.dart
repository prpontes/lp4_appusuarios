import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedor.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/provider/fornecedores_provider.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class MutateProductDialog extends StatefulWidget {
  final Product? product;
  const MutateProductDialog({Key? key, this.product}) : super(key: key);

  @override
  State<MutateProductDialog> createState() => _MutateProductDialogState();
}

class _MutateProductDialogState extends State<MutateProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "");
  final _descriptionController = TextEditingController(text: "");
  final _priceController = TextEditingController(text: "0.0");
  final _imageController = TextEditingController(text: "");
  Fornecedor? _selectedFornecedor;

  late final FornecedoresProvider _fornecedoresProvider;
  late final ProductProvider _productProvider;
  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _fornecedoresProvider =
        Provider.of<FornecedoresProvider>(context, listen: false);
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _imageController.text = widget.product!.image;
      _selectedFornecedor = widget.product!.fornecedor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.product != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("${isUpdate ? 'Editar' : 'Criar'} produto"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Product product = isUpdate
                ? widget.product!
                : Product(
                    name: _nameController.text,
                    fornecedor: _selectedFornecedor!,
                  );
            product.name = _nameController.text;
            product.description = _descriptionController.text.isEmpty
                ? ""
                : _descriptionController.text;
            product.price = _priceController.text.isNotEmpty
                ? double.parse(_priceController.text)
                : 0.0;
            product.image = _imageController.text;
            product.fornecedor = _selectedFornecedor!;
            await product.getMainColorFromImage();
            if (isUpdate) {
              await _productProvider.updateProduct(product);
            } else {
              await _productProvider.createProduct(product);
            }
            Navigator.of(context).pop();
          }
        },
        // icon approve
        child: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _fornecedoresProvider.listarFornecedores(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Fornecedor> fornecedores =
                    snapshot.data as List<Fornecedor>;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
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
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Preço',
                          hintText: "Preço",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Preço é obrigatório';
                          }
                          if (double.tryParse(value) == null ||
                              double.parse(value) <= 0) {
                            return 'Preço inválido';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _imageController,
                        decoration: const InputDecoration(
                          labelText: 'Imagem',
                          hintText: "Imagem",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<int>(
                        value: (_selectedFornecedor == null)
                            ? null
                            : _selectedFornecedor!.id,
                        hint: Text(
                          fornecedores.isNotEmpty
                              ? "Selecione o Fornecedor"
                              : "Nenhum Fornecedor Cadastrado",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        icon: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.chevron_right,
                              color: Colors.deepPurple),
                        ),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (_) {
                          if (_selectedFornecedor == null) {
                            return "Selecione um Fornecedor";
                          }
                          return null;
                        },
                        onChanged: (idSelecionado) {
                          setState(() {
                            _selectedFornecedor = fornecedores.firstWhere(
                                (fornecedor) => fornecedor.id == idSelecionado);
                          });
                        },
                        items: fornecedores.map<DropdownMenuItem<int>>(
                          (fornecedor) {
                            return DropdownMenuItem<int>(
                              value: fornecedor.id,
                              child: Text(
                                fornecedor.razaoSocial!,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          hintText: "Descrição",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

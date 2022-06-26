import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/fornecedorFirebase.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/provider/fornecedores_provider.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class MutateProductDialog extends StatefulWidget {
  final ProductNotifier? productNotifier;
  const MutateProductDialog({Key? key, this.productNotifier}) : super(key: key);

  @override
  State<MutateProductDialog> createState() => _MutateProductDialogState();
}

class _MutateProductDialogState extends State<MutateProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "");
  final _descriptionController = TextEditingController(text: "");
  final _priceController = TextEditingController(text: "0.0");
  final _imageController = TextEditingController(text: "");
  FornecedorFirebase? _selectedFornecedor;

  late final FornecedoresProvider _fornecedoresProvider;
  late final ProductProvider _productProvider;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _fornecedoresProvider = Provider.of<FornecedoresProvider>(context, listen: false);
    if (widget.productNotifier != null) {
      _nameController.text = widget.productNotifier!.product.name;
      _descriptionController.text = widget.productNotifier!.product.description;
      _priceController.text = widget.productNotifier!.product.price.toString();
      _imageController.text = widget.productNotifier!.product.image;
      _selectedFornecedor = widget.productNotifier!.product.fornecedor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.productNotifier != null;
    return WillPopScope(
      onWillPop: () async {
        if (_loading.value) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ValueListenableBuilder<bool>(
            valueListenable: _loading,
            builder: (_, value, __) {
              return AppBar(
                automaticallyImplyLeading: false,
                title: Text("${isUpdate ? 'Editar' : 'Criar'} produto"),
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: !value ? () => Navigator.of(context).pop() : null,
                ),
              );
            },
          ),
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
            valueListenable: _loading,
            builder: (_, value, __) => FloatingActionButton(
                  onPressed: !value
                      ? () async {
                          _loading.value = true;
                          try {
                            if (_formKey.currentState!.validate()) {
                              Product product = isUpdate
                                  ? widget.productNotifier!.product
                                  : Product(
                                      name: _nameController.text,
                                      fornecedor: _selectedFornecedor,
                                    );
                              product.name = _nameController.text;
                              product.description = _descriptionController.text.isEmpty ? "" : _descriptionController.text;
                              product.price = _priceController.text.isNotEmpty ? double.parse(_priceController.text) : 0.0;
                              product.image = _imageController.text;
                              product.fornecedor = _selectedFornecedor!;
                              if (isUpdate) {
                                await _productProvider.updateProduct(product);
                              } else {
                                await _productProvider.createProduct(product);
                              }
                              if (widget.productNotifier != null) {
                                widget.productNotifier!.refresh();
                              }
                              if (mounted) Navigator.of(context).pop();
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Error!'),
                            ));
                          } finally {
                            _loading.value = false;
                          }
                        }
                      : null,
                  // icon approve
                  child: const Icon(Icons.check),
                )),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: _fornecedoresProvider.listarFornecedorFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<FornecedorFirebase> fornecedores = snapshot.data as List<FornecedorFirebase>;
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
                                if (double.tryParse(value) == null || double.parse(value) <= 0) {
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
                            DropdownButtonFormField<String>(
                              value: (_selectedFornecedor == null) ? null : _selectedFornecedor!.id,
                              hint: Text(
                                fornecedores.isNotEmpty ? "Selecione o Fornecedor" : "Nenhum Fornecedor Cadastrado",
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                              icon: RotatedBox(
                                quarterTurns: 1,
                                child: Icon(Icons.chevron_right, color: Colors.deepPurple),
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
                                _selectedFornecedor = fornecedores.firstWhere((fornecedor) => fornecedor.id == idSelecionado);
                              },
                              items: fornecedores.map<DropdownMenuItem<String>>(
                                (fornecedor) {
                                  return DropdownMenuItem<String>(
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
            ValueListenableBuilder<bool>(
              valueListenable: _loading,
              builder: (_, loading, __) => Visibility(
                visible: loading,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

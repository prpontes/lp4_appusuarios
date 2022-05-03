import 'package:flutter/material.dart';
import 'package:lp4_appusuarios/model/product.dart';
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

  late final ProductProvider _productProvider;
  @override
  void initState() {
    super.initState();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _imageController.text = widget.product!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = widget.product != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("${isUpdate ? 'Editar' : 'Criar'} produto"),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          debugPrint("Formulário válido");
          if (_formKey.currentState!.validate()) {
            Product product = isUpdate
                ? widget.product!
                : Product(name: _nameController.text);
            product.name = _nameController.text;
            product.description = _descriptionController.text.isEmpty
                ? ""
                : _descriptionController.text;
            product.price = _priceController.text.isNotEmpty
                ? double.parse(_priceController.text)
                : 0.0;
            product.image = _imageController.text;
            product.idFornecedor = -1;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
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
                controller: _descriptionController,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: "Descrição",
                  border: OutlineInputBorder(),
                ),
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
                  if (double.tryParse(value) == null) {
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
            ],
          ),
        ),
      ),
    );
  }
}

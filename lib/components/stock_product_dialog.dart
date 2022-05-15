import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lp4_appusuarios/model/product.dart';
import 'package:lp4_appusuarios/provider/product_provider.dart';
import 'package:provider/provider.dart';

class StockDialog extends StatelessWidget {
  final Product product;
  late final TextEditingController _qtdController;
  final _formKey = GlobalKey<FormState>();
  StockDialog({Key? key, required this.product}) : super(key: key) {
    _qtdController = TextEditingController(text: product.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                "Quantidade em Estoque",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  IconButton(
                      focusNode: FocusNode(),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        try {
                          _qtdController.text =
                              _qtdController.text.isNotEmpty && double.tryParse(_qtdController.text) != null && double.parse(_qtdController.text) >= 1
                                  ? (double.parse(_qtdController.text) - 1).toInt().toString()
                                  : "0";
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                      )),
                  Expanded(
                    child: SizedBox(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _qtdController,
                          validator: (qtd) {
                            if (qtd!.isEmpty) {
                              return 'Digite uma quantidade';
                            }
                            if (double.tryParse(qtd) == null || double.parse(qtd) < 0) {
                              return 'Quantidade inválida';
                            }
                            return null;
                          },
                          maxLines: 1,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        _qtdController.text =
                            _qtdController.text.isNotEmpty && double.tryParse(_qtdController.text) != null && double.parse(_qtdController.text) >= 1
                                ? (double.parse(_qtdController.text) + 1).toInt().toString()
                                : "1";
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        product.quantity = double.parse(_qtdController.text).toInt();
                        await productProvider.updateProduct(product);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Estoque Atualizado!"),
                              ],
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: Text("Salvar"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DeleteProviderDialog extends StatefulWidget {
  final String title;
  final String description;
  const DeleteProviderDialog({Key? key, this.title = "", this.description = ""})
      : super(key: key);

  @override
  State<DeleteProviderDialog> createState() => _DeleteProviderDialogState();
}

class _DeleteProviderDialogState extends State<DeleteProviderDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.description),
      actions: [
        ElevatedButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        ElevatedButton(
          child: const Text('Excluir'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}

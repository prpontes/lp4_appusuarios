import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final String title;
  final String description;
  const DeleteDialog({Key? key, this.title = "", this.description = ""})
      : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
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

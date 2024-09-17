import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(String value, int priority);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    Key? key,
    required this.onListAdded,
  }) : super(key: key);

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  final TextEditingController _inputController = TextEditingController();
  int _priority = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(hintText: "Enter task description"),
          ),
          const SizedBox(height: 16),
          DropdownButton<int>(
            value: _priority,
            items: [1, 2, 3].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('Priority $value'),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _priority = newValue!;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          key: const Key("CancelButton"),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          key: const Key("OKButton"),
          child: const Text('Add'),
          onPressed: () {
            if (_inputController.text.isNotEmpty) {
              widget.onListAdded(_inputController.text, _priority);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Item> items = [const Item(name: "add more todos")];
  final _itemSet = <Item>{};

  void _handleListChanged(Item item, bool completed) {
    setState(() {
      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Item item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Item item = Item(name: itemText);  // Changed from const Item(name: "itemText")
      items.insert(0, item);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: items.map((item) {
          return ToDoListItem(
            item: item,
            completed: _itemSet.contains(item),
            onListChanged: _handleListChanged,
            onDeleteItem: _handleDeleteItem,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('AddButton'),  // Added key for testing
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return ToDoDialog(onListAdded: _handleNewItem);
            }
          );
        }
      )
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Do List',
    home: ToDoList(),
  ));
}
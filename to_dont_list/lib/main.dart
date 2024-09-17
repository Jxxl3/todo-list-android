import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/PriorityItem.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<PriorityItem> items = [];
  final _itemSet = <PriorityItem>{};

  void _handleListChanged(Item item, bool completed) {
    if (item is PriorityItem) {
      setState(() {
        if (completed) {
          _itemSet.add(item);
        } else {
          _itemSet.remove(item);
        }
        _sortItems();
      });
    }
  }

  void _handleDeleteItem(Item item) {
    if (item is PriorityItem) {
      setState(() {
        items.remove(item);
        _itemSet.remove(item);
      });
    }
  }

  void _handleNewItem(String itemText, int priority) {
    setState(() {
      PriorityItem item = PriorityItem(name: itemText, priority: priority);
      items.add(item);
      _sortItems();
    });
  }

  void _sortItems() {
    items.sort((a, b) {
      if (_itemSet.contains(a) != _itemSet.contains(b)) {
        return _itemSet.contains(a) ? 1 : -1;
      }
      return b.priority.compareTo(a.priority);
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
        key: const Key('AddButton'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return ToDoDialog(onListAdded: _handleNewItem);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
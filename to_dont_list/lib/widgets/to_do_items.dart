import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/PriorityItem.dart';

typedef ToDoListChangedCallback = Function(Item item, bool completed);
typedef ToDoListRemovedCallback = Function(Item item);

class ToDoListItem extends StatelessWidget {
  ToDoListItem({
    required this.item,
    required this.completed,
    required this.onListChanged,
    required this.onDeleteItem,
  }) : super(key: ObjectKey(item));

  final Item item;
  final bool completed;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    if (completed) return Colors.black54;
    if (item is PriorityItem) {
      final priorityItem = item as PriorityItem;
      switch (priorityItem.priority) {
        case 1:
          return Colors.green;
        case 2:
          return Colors.orange;
        case 3:
          return Colors.red;
        default:
          return Theme.of(context).primaryColor;
      }
    }
    return Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;
    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  String _getAbbrev() {
    if (item is PriorityItem) {
      return (item as PriorityItem).priority.toString();
    }
    return item.abbrev();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(item, completed);
      },
      onLongPress: completed ? () => onDeleteItem(item) : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(_getAbbrev()),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDeleteItem(item),
      ),
    );
  }
}
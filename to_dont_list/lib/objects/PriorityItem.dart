import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
class PriorityItem extends Item {
  final int priority;

  const PriorityItem({required String name, required this.priority}) : super(name: name);

  Map<String, dynamic> toJson() => {
    'name': name,
    'priority': priority,
  };

  factory PriorityItem.fromJson(Map<String, dynamic> json) {
    return PriorityItem(
      name: json['name'],
      priority: json['priority'],
    );
  }
}

class PrioritySelector extends StatefulWidget {
  final Function(int) onPrioritySelected;
  final int initialPriority;

  const PrioritySelector({Key? key, required this.onPrioritySelected, this.initialPriority = 1}) : super(key: key);

  @override
  _PrioritySelectorState createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  late int _priority;

  @override
  void initState() {
    super.initState();
    _priority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
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
          widget.onPrioritySelected(_priority);
        });
      },
    );
  }
}
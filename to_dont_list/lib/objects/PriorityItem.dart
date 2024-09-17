import 'package:to_dont_list/objects/item.dart';

class PriorityItem extends Item {
  final int priority;

  PriorityItem({required String name, required this.priority}) : super(name: name);

  @override
  String toString() {
    return '$name (Priority: $priority)';
  }

  String abbrev() {
    return priority.toString();
  }
}
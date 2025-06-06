import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/taks.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  final List<Tasks> taskList = [
    Tasks('Estudar Flutter', 'assets/images/dash.png', 4),
    Tasks('Andar de Bike', 'assets/images/bike.webp', 2),
    Tasks('Ler', 'assets/images/livro.jpg', 1),
    Tasks('Meditar', 'assets/images/meditar.jpeg', 3),
    Tasks('Jogar', 'assets/images/jogar.jpg', 2),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(Tasks(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}

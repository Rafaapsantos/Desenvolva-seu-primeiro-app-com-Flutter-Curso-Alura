import 'package:flutter/material.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
import 'package:primeiro_projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  double globalLevel = 0;
  double progressBarValue = 0;

  void refreshLevelPage() {
    setState(() {
      globalLevel = 0; //para resetar os valores armazenados em cache
      progressBarValue = 0; //para resetar os valores armazenados em cache
      for (var task in TaskInherited.of(context).taskList) {
        final taskLevel = (task.nivel * task.dificuldade) / 10;
        globalLevel += taskLevel;
      }
      progressBarValue = globalLevel / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Tarefas', style: TextStyle(color: Colors.white)),
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.white,
                    value: progressBarValue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Level Global: ${globalLevel.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {
                refreshLevelPage();
              },
              icon: Icon(Icons.loop, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 8, bottom: 90),
        children: TaskInherited.of(context).taskList,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

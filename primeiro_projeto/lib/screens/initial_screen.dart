import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/taks.dart';
import 'package:primeiro_projeto/data/task_dao.dart';
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
                setState(() {});
              },
              icon: Icon(Icons.loop, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 90),
        child: FutureBuilder<List<Tasks>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Tasks>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando '),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando '),
                    ],
                  ),
                );
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando '),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final Tasks tarefa = items[index];
                        return tarefa;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return Text('Erro ao carregar tarefas');
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          ).then(
            (value) => setState(() {
              print('Recarregando a tela inicial');
            }),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

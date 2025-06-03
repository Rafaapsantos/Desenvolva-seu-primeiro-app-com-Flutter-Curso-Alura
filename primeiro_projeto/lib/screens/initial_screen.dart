import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/taks.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas', style: TextStyle(color: Colors.white)),
        leading: Container(),
        backgroundColor: Colors.blue,
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: Duration(milliseconds: 800),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Tasks('Estudar Flutter', 'assets/images/dash.png', 4),
            ),
            Tasks('Andar de Bike', 'assets/images/bike.webp', 2),
            Tasks('Ler', 'assets/images/livro.jpg', 1),
            Tasks('Meditar', 'assets/images/meditar.jpeg', 3),
            Tasks('Jogar', 'assets/images/jogar.jpg', 2),
            SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            opacidade = !opacidade;
          });
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.remove_red_eye, color: Colors.white),
      ),
    );
  }
}

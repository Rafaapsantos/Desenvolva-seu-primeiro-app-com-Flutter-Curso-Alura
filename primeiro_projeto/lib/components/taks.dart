import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/difficulty.dart';
import 'package:primeiro_projeto/data/task_dao.dart';

class Tasks extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  Tasks(this.nome, this.foto, this.dificuldade, {super.key});
  int nivel = 0;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int maestria = 0;

  bool assetsOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  final List<Color> levelColors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.black,
  ];

  Color getCurrentColor() {
    return levelColors[maestria.clamp(0, levelColors.length - 1)];
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = getCurrentColor();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: currentColor,
            ),
            height: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child:
                            assetsOrNetwork()
                                ? Image.asset(
                                  widget.foto,
                                  fit: BoxFit.fitHeight,
                                )
                                : Image.network(widget.foto, fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(
                              fontSize: 24,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Difficulty(difficultyLevel: widget.dificuldade),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: ElevatedButton(
                          onLongPress: () {
                            TaskDao().delete(widget.nome);
                          },
                          onPressed: () {
                            setState(() {
                              int maxLevelPorDificuldade =
                                  widget.dificuldade * 10;

                              if (widget.nivel < maxLevelPorDificuldade) {
                                widget.nivel++;
                              } else {
                                maestria++;
                                widget.nivel = 1;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide.none,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up, color: Colors.white),
                              Text(
                                'UP',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value:
                            (widget.dificuldade > 0)
                                ? widget.nivel / (widget.dificuldade * 10)
                                : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

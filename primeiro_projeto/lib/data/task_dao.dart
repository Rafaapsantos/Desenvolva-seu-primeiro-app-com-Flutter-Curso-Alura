import 'package:primeiro_projeto/components/taks.dart';
import 'package:primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static String tableSql =
      'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTERGER ,'
      '$_image TEXT)';

  static String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'dificulty';
  static const String _image = 'image';

  save(Tasks tarefa) async {
    print('Iniciando o save:');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('A tarefa não existia');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('A tarefa ja existia');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Tasks tarefa) {
    print('Convertendo tarefa em map:');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;
    print('Mapa de tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Tasks>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
    );
    print('Procurando dados no BD... Encontrado $result');
    return toList(result);
  }

  List<Tasks> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Covertendo to list: ');
    final List<Tasks> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Tasks tarefa = Tasks(
        linha[_name],
        linha[_image],
        linha[_difficulty],
      );
      tarefas.add(tarefa);
    }
    print('Lista de tarefas $tarefas');
    return tarefas;
  }

  Future<List<Tasks>> find(String nomeDaTarefa) async {
    print('Acessando o find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}

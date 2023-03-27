import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/data/sql/task_sql.dart';

final sqlProvider = Provider<SqlDataSource>((ref) => SqlDataSource(ref));

class SqlDataSource {
  SqlDataSource(this.ref);

  final Ref ref;

  ///
  /// Task
  ///

  /// 投稿タスク追加
  Future<void> insertTask(Task taskSqlDoc) async {
    final database = ref.read(taskDatabaseProvider);
    await database.insert(taskSqlDoc.toCompanion(true));
  }

  Future<void> updateTask(Task taskSqlDoc) async {
    final database = ref.read(taskDatabaseProvider);
    await database.updateTask(taskSqlDoc.toCompanion(true));
  }

  Future<void> removeTask(String id) async {
    final database = ref.read(taskDatabaseProvider);
    await database.remove(id);
  }

  /// タスクのストリームを取得
  Stream<List<Task>> getTaskStream() {
    final database = ref.read(taskDatabaseProvider);
    final stream = database.fetchTaskStream();
    return stream;
  }

  /// タスクを全取得
  Future<List<Task>> getTasks() async {
    final db = ref.read(taskDatabaseProvider);
    final tasks = await db.fetchTasks();
    return tasks;
  }

  /// タスクを全消去
  Future<void> clearTasks() async {
    final database = ref.read(taskDatabaseProvider);
    await database.clear();
  }
}

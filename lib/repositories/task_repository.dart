import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/data/firestore_data_source.dart';
import 'package:flutter_template/data/sql_data_source.dart';
import 'package:flutter_template/entity/task/task_entity.dart';

final taskRepositoryProvider =
    Provider<TaskRepository>((ref) => TaskRepository(ref));

class TaskRepository {
  TaskRepository(this.ref);

  final Ref ref;

  /// 新規タスク追加
  Future<void> addTask(TaskEntity taskEntity) async {
    final sql = ref.read(sqlProvider);
    final firestore = ref.read(firestoreProvider);
    final taskSqlDoc = taskEntity.toSqlTaskDoc();
    final taskDoc = await taskEntity.toTaskDocument(ref);
    await sql.insertTask(taskSqlDoc);
    // ラグをなくすためにawaitをつけていない
    firestore.insertTask(taskDoc);
  }

  /// タスクの更新
  Future<void> updateTask(TaskEntity taskEntity) async {
    final sql = ref.read(sqlProvider);
    final firestore = ref.read(firestoreProvider);
    final taskSqlDoc = taskEntity.toSqlTaskDoc();
    final taskDoc = await taskEntity.toTaskDocument(ref);
    await sql.updateTask(taskSqlDoc);
    firestore.updateTask(taskDoc);
  }

  /// タスクの削除
  Future<void> finishTask(TaskEntity taskEntity) async {
    final sql = ref.read(sqlProvider);
    final firestore = ref.read(firestoreProvider);
    final taskSqlDoc = taskEntity.toSqlTaskDoc();
    await sql.removeTask(taskSqlDoc.id);
    await firestore.deleteTask(taskEntity.id);
  }

  /// タスクのストリームを取得
  Stream<List<TaskEntity>> getTaskStreamFromSql() {
    final sql = ref.read(sqlProvider);
    return sql.getTaskStream().map(
          (event) => event.map((e) => TaskEntity.fromSqlDoc(e)).toList(),
        );
  }
}

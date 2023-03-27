import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';

part 'task_sql.g.dart';

final taskDatabaseProvider = Provider<TasksDatabase>((ref) => TasksDatabase());

class Tasks extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  DateTimeColumn get deadline => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Tasks])
class TasksDatabase extends _$TasksDatabase {
  TasksDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.renameColumn(tasks, 'id', tasks.id);
          await m.alterTable(
            TableMigration(tasks, columnTransformer: {
              tasks.id: tasks.id.cast<String>(),
            }),
          );
        } else if (from < 3) {
          await m.alterTable(
            TableMigration(tasks, columnTransformer: {
              tasks.id: tasks.id.cast<String>(),
            }),
          );
        }
      },
    );
  }

  Stream<List<Task>> fetchTaskStream() {
    return (select(tasks)
          ..orderBy([
            (u) => OrderingTerm(expression: u.deadline, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future<List<Task>> fetchTasks() {
    return (select(tasks)).get();
  }

  Future<Task?> fetchTask(String title) {
    return (select(tasks)..where((tbl) => tbl.title.equals(title)))
        .getSingleOrNull();
  }

  Future<int> insert(TasksCompanion companion) {
    return into(tasks).insert(companion,
        onConflict: DoUpdate((_) => companion, target: [tasks.id]));
  }

  Future<int> updateTask(TasksCompanion companion) {
    return (update(tasks)..where((tbl) => tbl.id.equals(companion.id.value))).write(
      companion
    );
  }

  Future<void> remove(String id) {
    return (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> clear() async {
    await tasks.deleteAll();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'task_db.sqlite'));
    return NativeDatabase(file);
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_template/data/sql/task_sql.dart';
import 'package:flutter_template/documents/task_document/task_document.dart';
import 'package:flutter_template/providers/domain_providers.dart';

part 'task_entity.freezed.dart';

@freezed
class TaskEntity with _$TaskEntity {
  const TaskEntity._();

  const factory TaskEntity({
    required String id,
    required String title,
    required DateTime deadline,
  }) = _TaskEntity;

  static TaskEntity fromDoc(TaskDocument taskDoc) {
    return TaskEntity(
      id: taskDoc.taskId,
      title: taskDoc.title,
      deadline: taskDoc.deadline,
    );
  }

  Future<TaskDocument> toTaskDocument(Ref ref) async {
    return TaskDocument(
      userId: ref.read(uidProvider),
      token: ref.read(tokenProvider),
      taskId: id,
      title: title,
      deadline: deadline,
    );
  }

  static TaskEntity fromSqlDoc(Task taskSqlDoc) {
    return TaskEntity(
      id: taskSqlDoc.id,
      title: taskSqlDoc.title,
      deadline: taskSqlDoc.deadline,
    );
  }

  Task toSqlTaskDoc() {
    return Task(
      id: id,
      title: title,
      deadline: deadline,
    );
  }

  static TaskEntity create(WidgetRef ref, String title) {
    return TaskEntity(
      id: ref.read(uuidProvider).v4(),
      title: title,
      deadline: DateTime.now(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/documents/task_document/task_document.dart';
import 'package:flutter_template/providers/domain_providers.dart';
import 'package:flutter_template/providers/presentation_providers.dart';

final firestoreProvider =
    Provider<FirestoreDataSource>((ref) => FirestoreDataSource(ref: ref));

class FirestoreDataSource {
  FirestoreDataSource({required this.ref});

  final Ref ref;

  ///
  /// Task
  ///

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTaskStream() {
    try {
      final db = ref.read(firebaseFirestoreProvider);
      final uid = ref.read(uidProvider);

      final noticeStream = db
          .collection('tasks')
          .where('userId', isEqualTo: uid)
          .orderBy('deadline', descending: true)
          .snapshots();
      return noticeStream;
    } catch (e) {
      print('firestore_getTaskStream');
      throw e;
    }
  }

  /// 投稿タスク追加
  Future<void> insertTask(TaskDocument taskDocument) async {
    final db = ref.read(firebaseFirestoreProvider);
    final collection = db.collection('tasks');
    await collection.add(taskDocument.copyWith.call().toJson());
  }

  /// タスクの更新
  Future<void> updateTask(TaskDocument taskDocument) async {
    final db = ref.read(firebaseFirestoreProvider);
    final uid = ref.read(uidProvider);
    final collection = db.collection('tasks');

    final tasks = await collection
        .where('userId', isEqualTo: uid)
        .where('taskId', isEqualTo: taskDocument.taskId)
        .get();
    await collection
        .doc(tasks.docs.first.id)
        .update(taskDocument.copyWith.call().toJson());
  }

  /// タスクの削除
  Future<void> deleteTask(String taskId) async {
    final db = ref.read(firebaseFirestoreProvider);
    final col = db.collection('tasks');
  
    final tasks = await col
        .where('userId', isEqualTo: ref.read(uidProvider))
        .where('taskId', isEqualTo: taskId)
        .get();
    await col.doc(tasks.docs.first.id).delete();
  }

  /// すべてのタスクの削除
  Future<void> deleteAllTasks() async {
    final db = ref.read(firebaseFirestoreProvider);
    final col = db.collection('tasks');
    final tasks =
        await col.where('userId', isEqualTo: ref.read(uidProvider)).get();

    for (final did in tasks.docs.map((e) => e.id).toList()) {
      await col.doc(did).delete();
    }
  }
}

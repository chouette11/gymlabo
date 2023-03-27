import 'dart:async';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/data/firestore_data_source.dart';
import 'package:flutter_template/data/sql_data_source.dart';
import 'package:flutter_template/documents/task_document/task_document.dart';
import 'package:flutter_template/entity/task/task_entity.dart';
import 'package:flutter_template/providers/domain_providers.dart';
import 'package:flutter_template/repositories/task_repository.dart';
import 'package:flutter_template/repositories/user_repository.dart';

///
/// dialog
///

/// textFieldの状態
final textControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());

/// エラー文の状態
final isTextErrorProvider = StateNotifierProvider<IsTextErrorNotifier, bool>(
  (ref) => IsTextErrorNotifier(ref),
);

class IsTextErrorNotifier extends StateNotifier<bool> {
  IsTextErrorNotifier(this.ref) : super(false);
  final Ref ref;

  Future<void> error() async {
    state = true;
    Timer(Duration(seconds: 2), () {
      state = false;
    });
  }
}

///
/// top
///

///BottomNavigationBarのタブ数
final topTabIndexProvider = StateProvider<int>((_) => 0);

/// FloatingActionButtonが開いているか
final isOpenFloatingButtonProvider =
    StateProvider.autoDispose<bool>((ref) => false);

/// FloatingButtonのアニメーション
final animationControllerProvider = Provider.family.autoDispose(
  (ref, TickerProvider ticker) => AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: ticker,
  ),
);

final expandAnimationProvider = Provider.family.autoDispose(
  (ref, AnimationController _controller) => CurvedAnimation(
    curve: Curves.fastOutSlowIn,
    reverseCurve: Curves.easeOutQuad,
    parent: _controller,
  ),
);

///
/// task
///

/// タスク一覧StreamProvider
final tasksStreamProvider = StreamProvider<List<TaskEntity>>((ref) {

  /// Firestoreのタスクの更新を検知
  void change(QuerySnapshot<Map<String, dynamic>> event) async {
    for (final change in event.docChanges) {
      final data = change.doc.data();
      if (data == null) {
        break;
      }
      final task =
          (TaskEntity.fromDoc(TaskDocument.fromJson(data)).toSqlTaskDoc());
      switch (change.type) {
        case DocumentChangeType.added:
          await ref.read(sqlProvider).insertTask(task);
          break;
        case DocumentChangeType.removed:
          ref.read(sqlProvider).removeTask(task.id);
          break;
        case DocumentChangeType.modified:
          ref.read(sqlProvider).removeTask(task.id);
          ref.read(sqlProvider).insertTask(task);
          break;
      }
    }
  }

  final tasksListen =
      ref.read(firestoreProvider).fetchTaskStream().listen((event) async {
    change(event);
  });

  tasksListen.onError((e) => print('listen error: $e'));
  ref.onDispose(() async {
    await tasksListen.cancel();
  });

  return ref.read(taskRepositoryProvider).getTaskStreamFromSql();
});

///
/// login
///

final emailProvider = StateProvider<String>((ref) => '');

final passwordProvider = StateProvider<String>((ref) => '');

final authEmailErrorMsgProvider = StateProvider<String>((ref) => '');

final authThirdErrorMsgProvider = StateProvider<String>((ref) => '');

final uidProvider = StateProvider<String>((ref) {
  final user = ref.read(firebaseAuthProvider).currentUser;
  if (user == null) {
    return '';
  }
  return user.uid;
});

final isLoginUserProvider = StateProvider<bool>((ref) {
  final user = ref.read(firebaseAuthProvider).currentUser;
  if (user != null && user.emailVerified) {
    return true;
  } else {
    return false;
  }
});

///
/// camera
///

final cameraProvider = FutureProvider.autoDispose<CameraController?>(
  (ref) async {
    final cameras = ref.read(camerasProvider);
    if (cameras.isEmpty) {
      return null;
    }
    final camera = cameras.first;
    final controller =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    await controller.initialize();
    controller.setFlashMode(FlashMode.off);
    return controller;
  },
);

final cropDataProvider = StateProvider<Uint8List?>((ref) => null);

final isCameraProvider = StateProvider<bool>((ref) => false);

///
/// billing
///

final isProUserProvider = FutureProvider<bool>(
  (ref) async => await ref.read(userRepositoryProvider).getIsProUser(),
);

///
/// loading
///

final loadingProvider = NotifierProvider<LoadingNotifier, EasyLoading>(
  () => LoadingNotifier(),
);

class LoadingNotifier extends Notifier<EasyLoading> {
  @override
  EasyLoading build() {
    return EasyLoading.instance
      ..textStyle = TextStyle(fontSize: 0, color: Colors.white)
      ..textPadding = EdgeInsets.all(0)
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.white.withOpacity(0.5)
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.transparent
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  void showLoading() {
    EasyLoading.show();
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}

/// loadingのアニメーション
class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

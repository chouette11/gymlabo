import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/multi_floating_button/multi_floating_button.dart';
import 'package:flutter_template/pages/camera/camera_page.dart';
import 'package:flutter_template/pages/top/children/top_appbar.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/setting_repository.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'dart:async';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TopPage> createState() => _TopPageState();
}

class _TopPageState extends ConsumerState<TopPage> {
  @override
  void initState() {
    Future(
      () async {
        await ref.read(userRepositoryProvider).autoLogin();
        await ref.read(settingRepositoryProvider).generateFCMToken();
      },
    );
    super.initState();

    // アプリが開いていた時
    ReceiveSharingIntent.getTextStream().listen((String value) {
      print('外部アプリから開かれました');
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    //アプリが閉じていた時
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value == null) {
        return;
      }
      print('外部アプリから開かれました');
    }, onError: (err) {
      print("getLinkStream error: $err");
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksStreamProvider);
    final isCamera = ref.watch(isCameraProvider);
    return Scaffold(
      floatingActionButton: isCamera ? null : MultiFloatingButton(),
      body: Stack(
        children: [
          Scaffold(
            appBar: TopAppbar(),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 136,
              child: tasks.when(
                data: (data) {
                  if (isCamera) {
                    return CameraPage();
                  }
                  return ListView(
                    children: data
                        .map((e) => ListTile(title: Text(e.title)))
                        .toList(),
                  );
                },
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

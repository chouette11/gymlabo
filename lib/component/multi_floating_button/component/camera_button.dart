import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';

class CameraButton extends ConsumerWidget {
  const CameraButton(this.ticker, {Key? key}) : super(key: key);
  final TickerProvider ticker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      width: 48,
      child: FloatingActionButton(
        tooltip: 'add',
        onPressed: () {
          ref.read(isCameraProvider.notifier).update((state) => true);
          ref.read(animationControllerProvider(ticker)).reverse();
          ref
              .watch(isOpenFloatingButtonProvider.notifier)
              .update((state) => !state);
        },
        backgroundColor: ColorConstant.purple40,
        child: Icon(
          Icons.camera_alt,
          color: ColorConstant.black100,
        ),
      ),
    );
  }
}

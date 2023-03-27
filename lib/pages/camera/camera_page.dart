import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/pages/camera/component/take_button.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/utils/context_extension.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({
    Key? key,
  }) : super(key: key);

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends ConsumerState<CameraPage> {
  CameraDescription? camera;
  double x = 0;
  double y = 0;

  double mediaWidth = 80;
  double scaleWidthFactor = 1;

  double minWidth = 40;
  double maxWidth = 160;

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(cameraProvider);
    final double left = 24;
    final double top = 152;

    Future<void> _onTap(TapDownDetails details) async {
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * controller.value!.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp, yp);

      // Manually focus
      await controller.value!.setFocusPoint(point);
    }

    return Scaffold(
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          onPressed: () =>
              ref.read(isCameraProvider.notifier).update((state) => false),
          backgroundColor: ColorConstant.black100,
          child: Icon(Icons.close, color: ColorConstant.purple40),
        ),
      ),
      body: Scaffold(
        floatingActionButton: TakePictureButton(left: left, top: top),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: GestureDetector(
          onTapDown: _onTap,
          onDoubleTap: () {
            controller.value!.setZoomLevel(1);
            scaleWidthFactor = 1;
          },
          onScaleStart: (ScaleStartDetails data) {
            controller.value!.setZoomLevel(scaleWidthFactor);
          },
          onScaleUpdate: (ScaleUpdateDetails data) {
            if (scaleWidthFactor < 0.9) {
              controller.value!.setZoomLevel(data.scale);
            } else if (data.scale > scaleWidthFactor) {
              scaleWidthFactor = data.scale;
              controller.value!.setZoomLevel(data.scale);
            } else if (data.scale <= 1) {
              controller.value!
                  .setZoomLevel(scaleWidthFactor -= ((1 - data.scale) / 10));
            }
          },
          onScaleEnd: (ScaleEndDetails data) {
            if (scaleWidthFactor != 1.0) {
              controller.value!.setZoomLevel(scaleWidthFactor);
            }
          },
          child: Stack(
            children: [
              Center(
                child: controller.when(
                  data: (data) => SizedBox(
                    width: context.screenWidth,
                    child: CameraPreview(data!),
                  ),
                  error: (error, _) => Text('カメラが許可されていません。\nカメラの許可をお願いします。'),
                  loading: () => Container(color: Colors.black),
                ),
              ),
              Positioned(
                top: top,
                left: left,
                child: Container(
                  height: 144,
                  width: context.screenWidth - left * 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.red, width: 4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

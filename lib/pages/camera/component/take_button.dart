import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:image/image.dart' as image;
import 'package:flutter_template/utils/context_extension.dart';

class TakePictureButton extends ConsumerWidget {
  const TakePictureButton({
    Key? key,
    required this.left,
    required this.top,
  }) : super(key: key);
  final double left;
  final double top;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 72,
      height: 72,
      child: FloatingActionButton(
        onPressed: () async {
          final image = await ref.read(cameraProvider).value!.takePicture();
          final data = await File(image.path).readAsBytes();
          final targetImage = fromByteData(data);

          final cropResult = compute(
            doCrop,
            [
              targetImage,
              Rect.fromLTWH(
                20,
                top * targetImage.height / context.screenHeight + 60,
                context.screenWidth * targetImage.width / context.screenWidth,
                180 * targetImage.height / context.screenHeight,
              ),
            ],
          );
          ref.read(isCameraProvider.notifier).update((state) => false);
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SizedBox.shrink(),
              );
            },
          );
        },
        child: Icon(Icons.camera_alt, size: 32),
        backgroundColor: ColorConstant.purple40,
      ),
    );
  }
}

Uint8List doCrop(List<dynamic> cropData) {
  final originalImage = cropData[0] as image.Image;
  final rect = cropData[1] as Rect;
  return Uint8List.fromList(
    image.encodePng(
      image.copyCrop(
        originalImage,
        x: rect.left.toInt(),
        y: rect.top.toInt(),
        width: rect.width.toInt(),
        height: rect.height.toInt(),
      ),
    ),
  );
}

image.Image fromByteData(Uint8List data) {
  final tempImage = image.decodeImage(data);
  assert(tempImage != null);
  if (tempImage!.width > tempImage.height) {
    return image.copyRotate(tempImage, angle: 90);
  } else {
    return tempImage;
  }
}

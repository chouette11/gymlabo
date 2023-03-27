import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';

enum SnackBarStatus {
  success,
  error,
  info,
}

class AppSnackBar {
  AppSnackBar._({
    required this.messenger,
  });
  final ScaffoldMessengerState messenger;

  factory AppSnackBar.of({
    required ScaffoldMessengerState messager,
  }) {
    return AppSnackBar._(
      messenger: messager,
    );
  }

  void show(
      String title, {
        SnackBarStatus status = SnackBarStatus.info,
      }) {
    messenger.clearSnackBars();
    messenger.showSnackBar(
      customSnackBar(
        CustomSnackBar(
          title,
          status: status,
          messenger: messenger,
        ),
      ),
    );
  }
}

SnackBar customSnackBar(Widget content) {
  return SnackBar(
    content: content,
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(0),
  );
}

class CustomSnackBar extends ConsumerWidget {
  const CustomSnackBar(
      this.title, {
        Key? key,
        this.status = SnackBarStatus.info,
        required this.messenger,
      }) : super(key: key);
  final String title;
  final SnackBarStatus status;
  final ScaffoldMessengerState messenger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var icon = Icons.info_outline;
    switch (status) {
      case SnackBarStatus.success:
        icon = Icons.check_circle_outline;
        break;
      case SnackBarStatus.error:
        icon = Icons.error_outline;
        break;
      case SnackBarStatus.info:
        icon = Icons.info_outline;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: ColorConstant.black95,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Icon(
                    icon,
                    color: ColorConstant.black0,
                  ),
                ),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyleConstant.normal16,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Icon(
              Icons.close,
              color: ColorConstant.black0,
            ),
            onTap: () => messenger.hideCurrentSnackBar(),
          ),
        ],
      ),
    );
  }
}
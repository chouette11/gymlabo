import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';

/// プライマリーカラーボタン
class PrimaryFilledButton extends ConsumerWidget {
  const PrimaryFilledButton(
      this.text, {
        Key? key,
        required this.onPressed,
        this.disabled = false,
      }) : super(key: key);
  final String text;
  final void Function() onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !disabled ? onPressed : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              text,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorConstant.black100,
          backgroundColor: ColorConstant.purple40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
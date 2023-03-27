import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';

class CustomOutlinedButton extends ConsumerWidget {
  const CustomOutlinedButton(
      this.text, {
        Key? key,
        required this.onPressed,
      }) : super(key: key);
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ColorConstant.purple40;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            text,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(
            width: 2,
            color: color,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
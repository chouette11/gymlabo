import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';

class SwitchButton extends ConsumerWidget {
  const SwitchButton({
    Key? key,
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);
  final bool isSelected;
  final Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch(
      value: isSelected,
      activeColor: ColorConstant.purple40,
      onChanged: onChanged,
    );
  }
}

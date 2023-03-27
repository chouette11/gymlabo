import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/snack_bar.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/data/billiing_data_source.dart';
import 'package:flutter_template/utils/context_extension.dart';

class SettingAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const SettingAppbar({
    super.key,
    this.isBack = true,
    this.isTag = false,
    this.isBilling = false,
  });

  final bool isBack;
  final bool isTag;
  final bool isBilling;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height - 4);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: ColorConstant.purple100,
      foregroundColor: ColorConstant.purple0,
      elevation: 0,
      title: Text(context.l10n.setting),
      automaticallyImplyLeading: isBack,
      actions: [
        GestureDetector(
          onTap: () async {
            await ref.read(billingProvider).restore();
            AppSnackBar.of(messager: ScaffoldMessenger.of(context))
                .show(context.l10n.noRestoreMessage);
          },
          child: Visibility(
            visible: isBilling,
            child: Container(
              // transparentによる色の設定でGesturedDetectorが認識する
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    context.l10n.restore,
                    style: TextStyleConstant.bold12.copyWith(
                      color: ColorConstant.purple40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

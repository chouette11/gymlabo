import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/pages/login/sigh_up_page.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/utils/context_extension.dart';
import 'package:flutter_template/utils/date_time_extension.dart';

class TopAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const TopAppbar({super.key, this.actions});

  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height - 4);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final isLoginUser = ref.watch(isLoginUserProvider);
    return AppBar(
      backgroundColor: ColorConstant.purple100,
      foregroundColor: ColorConstant.purple0,
      elevation: 0.5,
      centerTitle: true,
      leading: !isLoginUser
          ? SizedBox(width: 80)
          : null,
      actions: [
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SignUpPage(),
            ),
          ),
          child: Visibility(
            visible: !isLoginUser,
            child: Container(
              // transparentによる色の設定でGesturedDetectorが認識する
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    context.l10n.signUp,
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
      title: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: today.M,
                style: TextStyle(
                  color: ColorConstant.black0,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: context.l10n.month,
                style: TextStyle(
                  color: ColorConstant.black0,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: today.d,
                style: TextStyle(
                  color: ColorConstant.black0,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: context.l10n.day,
                style: TextStyle(
                  color: ColorConstant.black0,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

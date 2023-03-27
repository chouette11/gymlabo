import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/pages/login/login_page.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton(this.userData, {Key? key}) : super(key: key);
  final List<UserInfo> userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        ref.read(loadingProvider.notifier).showLoading();
        userData.isNotEmpty
            ? await ref.read(userRepositoryProvider).logout()
            : showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: LoginPage(),
                ),
              );
        ref.read(loadingProvider.notifier).dismissLoading();
      },
      child: userData.isNotEmpty
          ? Text(
              context.l10n.logout,
              style: TextStyleConstant.bold14.copyWith(
                color: ColorConstant.red,
              ),
            )
          : Text(
              context.l10n.login,
              style: TextStyleConstant.bold14.copyWith(
                color: ColorConstant.defaultColor,
              ),
            ),
    );
  }
}

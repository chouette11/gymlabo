import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class AppleButton extends ConsumerWidget {
  const AppleButton({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        isLogin
            ? await ref.read(userRepositoryProvider).loginWithApple()
            : await ref.read(userRepositoryProvider).signUpWithApple();
        context.pop();
      },
      child: SizedBox(
        height: 56,
        width: 300,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(IconData(0xf04be, fontFamily: 'MaterialIcons')),
              SizedBox(width: 8),
              Text(
                isLogin
                    ? context.l10n.loginWithApple
                    : context.l10n.signUpWithApple,
                style: TextStyleConstant.normal14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

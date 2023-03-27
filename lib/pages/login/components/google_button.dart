import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        ref.read(loadingProvider.notifier).showLoading();
        isLogin
            ? await ref.read(userRepositoryProvider).loginWithGoogle()
            : await ref.read(userRepositoryProvider).signUpWithGoogle();
        ref.read(loadingProvider.notifier).dismissLoading();
        context.pop();
      },
      child: SizedBox(
        height: 56,
        width: 300,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_icon.png',
                width: 24,
              ),
              SizedBox(width: 8),
              Text(
                isLogin
                    ? context.l10n.loginWithGoogle
                    : context.l10n.signUpWithGoogle,
                style: TextStyleConstant.normal14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

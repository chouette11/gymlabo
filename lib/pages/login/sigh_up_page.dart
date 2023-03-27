import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/primary_button.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/functions/email_validation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/pages/login/components/apple_button.dart';
import 'package:flutter_template/pages/login/components/google_button.dart';
import 'package:flutter_template/pages/login/login_page.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final error = ref.watch(authEmailErrorMsgProvider);

    return SizedBox(
      width: 320,
      height: 440,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    context.l10n.signUp,
                    style: TextStyleConstant.bold20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.pop();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        context.l10n.login,
                        style: TextStyleConstant.bold12.copyWith(
                          color: ColorConstant.defaultColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                context.l10n.signUpWithSocialAccount,
                style: TextStyleConstant.bold12,
              ),
              SizedBox(height: 8),
              GoogleButton(isLogin: false),
              Visibility(
                visible: Platform.isIOS,
                child: AppleButton(isLogin: false),
              ),
              SizedBox(height: 24),
              Text(
                context.l10n.signUpWithMailAddress,
                style: TextStyleConstant.bold12,
              ),
              SizedBox(height: 16),
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: email,
                  onChanged: (value) =>
                      ref.read(emailProvider.notifier).update((state) => value),
                  validator: emailValidation,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    hintText: context.l10n.mailAddress,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                initialValue: password,
                onChanged: (value) => ref
                    .read(passwordProvider.notifier)
                    .update((state) => value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintText: context.l10n.passWord,
                ),
                obscureText: true,
              ),
              Visibility(
                visible: error.isNotEmpty,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      error,
                      style: TextStyleConstant.bold12.copyWith(
                        color: ColorConstant.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              PrimaryFilledButton(
                context.l10n.signUp,
                disabled: email.isEmpty ||
                    password.isEmpty ||
                    emailValidation(email) != null,
                onPressed: () async => await ref
                    .read(userRepositoryProvider)
                    .signUpWithEmail(email, password, context),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

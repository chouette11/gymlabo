import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/outline_button.dart';
import 'package:flutter_template/component/primary_button.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/functions/email_validation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class ForgetPasswordPage extends ConsumerWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final error = ref.watch(authEmailErrorMsgProvider);

    return SizedBox(
      width: 320,
      height: 360,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Text(
              context.l10n.resettingPassword,
              style: TextStyleConstant.bold20,
            ),
            SizedBox(height: 24),
            Text(
              context.l10n.inputMailAddress,
              textAlign: TextAlign.center,
              style: TextStyleConstant.normal14,
            ),
            SizedBox(height: 24),
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
            SizedBox(height: 8),
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
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            PrimaryFilledButton(
              context.l10n.resettingPassword,
              disabled: emailValidation(email) != null,
              onPressed: () {
                ref.read(userRepositoryProvider).passwordReset(email, context);
              },
            ),
            SizedBox(height: 16),
            // キャンセルボタン
            CustomOutlinedButton(
              context.l10n.cancel,
              onPressed: context.pop,
            ),
          ],
        ),
      ),
    );
  }
}

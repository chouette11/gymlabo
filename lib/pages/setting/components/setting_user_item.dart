import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/pages/setting/components/auth_button.dart';
import 'package:flutter_template/providers/domain_providers.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class SettingUserItem extends ConsumerWidget {
  const SettingUserItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseAuthProvider).currentUser!;
    final email = user.email;
    final isEmailVerified = user.emailVerified;
    final imageUrl =
        user.providerData.isNotEmpty ? user.providerData.first.photoURL : null;
    final isLogin = ref.watch(isLoginUserProvider);
    final userData = user.providerData;
    return Container(
      // 色の設定によりGestureDetectorが機能する
      color: Colors.transparent,
      margin: EdgeInsets.only(right: 16, left: 16),
      height: 64,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: isLogin
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    UserIcon(imageUrl: imageUrl),
                                    SizedBox(width: 16),
                                    UserEmail(
                                      isEmailVerified: isEmailVerified,
                                      email: email,
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: DeleteAccountButton(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    : null,
                child: UserIcon(imageUrl: imageUrl),
              ),
              SizedBox(width: 16),
              UserEmail(
                isEmailVerified: isEmailVerified,
                email: email,
              ),
            ],
          ),
          AuthButton(userData),
        ],
      ),
    );
  }
}

class UserIcon extends StatelessWidget {
  const UserIcon({Key? key, this.imageUrl}) : super(key: key);
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(imageUrl!),
              ),
            ),
          )
        : Icon(
            Icons.account_circle,
            size: 56,
            color: Colors.grey,
          );
  }
}

class UserEmail extends StatelessWidget {
  const UserEmail({
    Key? key,
    required this.isEmailVerified,
    required this.email,
  }) : super(key: key);
  final bool isEmailVerified;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth - 204,
      child: isEmailVerified
          ? FittedBox(
              child: Text(email!),
            )
          : email != null && email!.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(context.l10n.pleaseVerifyEmailAddress),
                    ),
                    FittedBox(
                      child: Text('($email)'),
                    ),
                  ],
                )
              : Text(context.l10n.guest),
    );
  }
}

class DeleteAccountButton extends ConsumerWidget {
  const DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n.deleteAccountConfirm),
                TextButton(
                  onPressed: () async =>
                      await ref.read(userRepositoryProvider).deleteAccount(),
                  child: Text(
                    context.l10n.delete,
                    style: TextStyleConstant.bold14.copyWith(
                      color: ColorConstant.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Text(
        context.l10n.delete,
        style: TextStyleConstant.bold14.copyWith(
          color: ColorConstant.red,
        ),
      ),
    );
  }
}

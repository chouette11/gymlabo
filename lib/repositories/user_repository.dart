import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/functions/show_reset_password.dart';
import 'package:flutter_template/functions/show_verify_email.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/data/billiing_data_source.dart';
import 'package:flutter_template/data/firebase_auth_data_source.dart';
import 'package:flutter_template/data/firestore_data_source.dart';
import 'package:flutter_template/providers/presentation_providers.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref));

class UserRepository {
  UserRepository(this.ref);

  final Ref ref;

  /// 自動ログイン
  Future<void> autoLogin() async {
    final auth = ref.read(authProvider);
    await auth.autoLogin();
    _refresh(ref);
  }

  /// メールアドレスでサインアップ
  Future<void> signUpWithEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    final auth = ref.read(authProvider);
    await auth.emailSignUp(email, password);
    _refresh(ref);
    showVerifyEmailDialog(email, context);
  }

  /// メールアドレスでログイン
  Future<void> loginUserWithEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    final auth = ref.read(authProvider);
    ref.read(firestoreProvider).deleteAllTasks();
    await auth.emailLogin(email, password, context);
    _refresh(ref);
    context.pop();
  }

  /// パスワードリセット
  Future<void> passwordReset(String email, BuildContext context) async {
    final auth = ref.read(authProvider);
    await auth.sendResetPasswordEmail(email);
    context.pop();
    showResetPasswordDialog(email, context);
  }

  /// googleで登録
  Future<void> signUpWithGoogle() async {
    final auth = ref.read(authProvider);
    await auth.googleSignUp();
    _refresh(ref);
  }

  /// googleでログイン
  Future<void> loginWithGoogle() async {
    final auth = ref.read(authProvider);
    await auth.googleLogin();
    _refresh(ref);
  }

  /// appleで登録
  Future<void> signUpWithApple() async {
    final auth = ref.read(authProvider);
    await auth.appleSignUp();
    _refresh(ref);
  }

  /// appleでログイン
  Future<void> loginWithApple() async {
    final auth = ref.read(authProvider);
    await auth.appleLogin();
    _refresh(ref);
  }

  /// ログアウト
  Future<void> logout() async {
    final auth = ref.read(authProvider);
    await auth.logout();
    _refresh(ref);
  }

  /// アカウント消去
  Future<void> deleteAccount() async {
    final auth = ref.read(authProvider);
    await auth.deleteAccount();
    _refresh(ref);
  }

  ///
  /// billing
  ///

  Future<bool> getIsProUser() async {
    final bill = ref.read(billingProvider);
    final info = await bill.getCustomerInfo();
    return info.activeSubscriptions.contains(BillingIdentifier.monthly.value);
  }
}

void _refresh(Ref ref) {
  ref.refresh(uidProvider);
  ref.refresh(isLoginUserProvider);
  ref.refresh(tasksStreamProvider);
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/functions/show_verify_email.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_template/providers/domain_providers.dart';
import 'package:googleapis/run/v1.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_template/providers/presentation_providers.dart';

final authProvider =
    Provider<FirebaseAuthDataSource>((ref) => FirebaseAuthDataSource(ref: ref));

class FirebaseAuthDataSource {
  FirebaseAuthDataSource({required this.ref});

  final Ref ref;

  /// 自動ログイン
  Future<void> autoLogin() async {
    final auth = ref.read(firebaseAuthProvider);
    final user = auth.currentUser;
    if (user == null) {
      await auth.signInAnonymously();
      return;
    }
    if (user.email == null) {
      await auth.signInAnonymously();
    }
  }

  /// emailサインアップ
  Future<void> emailSignUp(String email, String password) async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print('sign up error');
      print(e.message);
      emailSignUpError(e.code, ref, e.message);
    } catch (e) {
      print(e);
    }
  }

  /// emailログイン
  Future<void> emailLogin(
      String email, String password, BuildContext context) async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('email login error');
      print(e.code);
      emailLoginError(e.code, ref, e.message, email, context);
    } catch (e) {
      print(e);
    }
  }

  /// emailリセット
  Future<void> sendResetPasswordEmail(String email) async {
    final auth = ref.read(firebaseAuthProvider);
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        pushEmailError(ref, 'メールアドレスが間違っているか存在しません');
        throw ExecAction();
      } else if (e.code == 'invalid-email') {
        pushEmailError(ref, 'メールアドレスが無効です');
        throw ExecAction();
      } else {
        print('予期せぬエラーです');
      }
    } catch (e) {
      print(e);
    }
  }

  /// googleサインアップ
  Future<void> googleSignUp() async {
    final auth = ref.read(firebaseAuthProvider);
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final googleAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      try {
        await auth.currentUser!.linkWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        thirdSignUpError(e.code, ref);
      } catch (e) {
        print(e);
      }
    }
  }

  /// googleログイン
  Future<void> googleLogin() async {
    final auth = ref.read(firebaseAuthProvider);
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final googleAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        print(e.message);
        thirdLoginError(e.code, ref, e.message);
      } catch (e) {
        print(e);
      }
    }
  }

  /// appleサインイン
  Future<void> appleSignUp() async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // OAthCredentialのインスタンスを作成
      OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      try {
        await auth.currentUser!.linkWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        thirdSignUpError(e.code, ref);
      }
    } catch (e) {
      print('apple sign up error: $e');
    }
  }

  /// appleログイン
  Future<void> appleLogin() async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // OAthCredentialのインスタンスを作成
      OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      try {
        await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        thirdLoginError(e.code, ref, e.message);
      }
    } catch (e) {
      print('apple sign up error: $e');
    }
  }

  /// すでに登録してあるかどうか
  Future<bool?> checkExistUser(String email) async {
    final auth = ref.read(firebaseAuthProvider);
    try {
      final list = await auth.fetchSignInMethodsForEmail(email);
      return list.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      if (e.code == EmailLoginError.invalidEmail.name) {
        print('emailが間違っています');
      } else {
        print('予期せぬエラーです');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// ログアウト
  Future<void> logout() async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      await auth.signOut();
      await autoLogin();
    } catch (e) {
      print('logout error $e');
    }
  }

  ///　アカウントの削除
  Future<void> deleteAccount() async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      await auth.currentUser!.delete();
      await autoLogin();
    } catch (e) {}
  }
}

enum LoginStatus {
  notLogin,
  autoLogin,
  googleLogin,
  emailLogin,
  emailVerified;
}

enum EmailSighUpError {
  emailAlreadyInUse('email-already-in-use', 'このメールアドレスは使われています'),
  invalidEmail('invalid-email', '無効なメールアドレスです'),
  weekPassword('weak-password', 'パスワードが弱いです'),
  unknown('unknown', '予期せぬエラーです');

  const EmailSighUpError(this.value, this.text);

  final String value;
  final String text;
}

void emailSignUpError(String error, Ref ref, String? message) {
  if (error == EmailSighUpError.weekPassword.value) {
    pushEmailError(ref, EmailSighUpError.weekPassword.text);
    throw ExecAction();
  } else if (error == EmailSighUpError.emailAlreadyInUse.value) {
    pushEmailError(ref, EmailSighUpError.emailAlreadyInUse.text);
    throw ExecAction();
  } else if (error == EmailSighUpError.invalidEmail.value) {
    pushEmailError(ref, EmailSighUpError.invalidEmail.text);
    throw ExecAction();
  } else if (message?.contains('BLOCKING_FUNCTION_ERROR_RESPONSE') ?? false) {
  } else {
    pushEmailError(ref, EmailSighUpError.unknown.text);
  }
}

enum EmailLoginError {
  invalidEmail('invalid-email', 'emailが間違っています'),
  userDisabled('user-disabled', 'ユーザーが無効です。お問い合わせください'),
  userNotFound('user-not-found', 'ユーザーが見つかりません'),
  wrongPassword('wrong-password', 'パスワードが間違っています'),
  tooManyRequests('too-may-requests', 'しばらくしてから再度お試しください'),
  unknown('unknown', '予期せぬエラーです');

  const EmailLoginError(this.value, this.text);

  final String value;
  final String text;
}

void emailLoginError(String error, Ref ref, String? message, String email,
    BuildContext context) {
  if (error == EmailLoginError.invalidEmail.value) {
    pushEmailError(ref, EmailLoginError.invalidEmail.text);
    throw ExecAction();
  } else if (error == EmailLoginError.userDisabled.value) {
    pushEmailError(ref, EmailLoginError.userDisabled.text);
    throw ExecAction();
  } else if (error == EmailLoginError.userNotFound.value) {
    pushEmailError(ref, EmailLoginError.userNotFound.text);
    throw ExecAction();
  } else if (error == EmailLoginError.wrongPassword.value) {
    pushEmailError(ref, EmailLoginError.wrongPassword.text);
    throw ExecAction();
  } else if (message?.contains('BLOCKING_FUNCTION_ERROR_RESPONSE') ?? false) {
    showVerifyEmailDialog(email, context);
    throw Error();
  } else {
    pushEmailError(ref, EmailLoginError.unknown.text);
    throw ExecAction();
  }
}

enum ThirdSignUpError {
  invalidCredential('invalid-credential', 'ログインが無効です'),
  providerAlreadyLinked('provider-already-linked', 'このアカウントはすでに使われています'),
  emailAlreadyInUse('email-already-in-use', 'このメールアドレスは使われています'),
  operationNotAllowed('operation-not-allowed', 'ログインが無効です'),
  credentialAlreadyInUse('credential-already-in-use', 'このアカウントは使われています'),
  invalidEmail('invalid-email', 'emailが間違っています'),
  invalidVerificationCode('invalid-verification-code', '認証コードが無効です'),
  invalidVerificationId('invalid-verification-id', '認証IDが無効です'),
  unknown('unknown', '予期せぬエラーです');

  const ThirdSignUpError(this.value, this.text);

  final String value;
  final String text;
}

void thirdSignUpError(String error, Ref ref) {
  if (error == ThirdSignUpError.invalidCredential.name) {
    pushThirdError(ref, ThirdSignUpError.invalidCredential.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.providerAlreadyLinked.name) {
    pushThirdError(ref, ThirdSignUpError.providerAlreadyLinked.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.emailAlreadyInUse.name) {
    pushThirdError(ref, ThirdSignUpError.emailAlreadyInUse.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.operationNotAllowed.name) {
    pushThirdError(ref, ThirdSignUpError.operationNotAllowed.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.credentialAlreadyInUse.name) {
    pushThirdError(ref, ThirdSignUpError.credentialAlreadyInUse.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.invalidEmail.name) {
    pushThirdError(ref, ThirdSignUpError.invalidEmail.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.invalidVerificationCode.name) {
    pushThirdError(ref, ThirdSignUpError.invalidVerificationCode.text);
    throw ExecAction();
  } else if (error == ThirdSignUpError.invalidVerificationId.name) {
    pushThirdError(ref, ThirdSignUpError.invalidVerificationId.text);
    throw ExecAction();
  } else {
    pushThirdError(ref, ThirdSignUpError.unknown.text);
    throw ExecAction();
  }
}

enum ThirdLoginError {
  accountExistsWithDifferentCredential(
      'account-exists-with-different-credential', 'このアカウントはすでに使われています'),
  invalidCredential('invalid-credential', 'ログインが無効です'),
  operationNotAllowed('operation-not-allowed', 'ログインが無効です'),
  userDisabled('user-disabled', 'ユーザーが無効です。お問い合わせください。'),
  userNotFound('user-not-found', 'ユーザーが見つかりません'),
  wrongPassword('wrong-password', 'パスワードが間違っています'),
  invalidVerificationCode('invalid-verification-code', '認証コードが無効です'),
  invalidVerificationId('invalid-verification-id', '認証IDが無効です'),
  invalidPro('', '無料枠の同時デバイス数は2つまでです\n他の端末でログアウトするか設定 -> プレミアム から登録してください'),
  unknown('unknown', '予期せぬエラーです');

  const ThirdLoginError(this.value, this.text);

  final String value;
  final String text;
}

void thirdLoginError(String error, Ref ref, String? message) {
  if (error == ThirdLoginError.accountExistsWithDifferentCredential.name) {
    pushThirdError(
        ref, ThirdLoginError.accountExistsWithDifferentCredential.text);
    throw ExecAction();
  } else if (error == ThirdLoginError.invalidCredential.name) {
    pushThirdError(ref, ThirdLoginError.invalidCredential.text);
    throw ExecAction();
  } else if (error == ThirdLoginError.operationNotAllowed.name) {
    pushThirdError(ref, ThirdLoginError.operationNotAllowed.text);
    throw ExecAction();
  } else if (error == ThirdLoginError.userDisabled.name) {
    pushThirdError(ref, ThirdLoginError.userDisabled.text);
    throw ExecAction();
  } else if (error == ThirdLoginError.userNotFound.name) {
    pushThirdError(ref, ThirdLoginError.userNotFound.text);
    throw ExecAction();
  } else if (error == ThirdLoginError.invalidVerificationCode.name) {
    pushThirdError(ref, ThirdLoginError.invalidVerificationCode.text);
    throw ExecAction();
  } else if (error == ThirdLoginError.invalidVerificationId.name) {
    pushThirdError(ref, ThirdLoginError.invalidVerificationId.text);
    throw ExecAction();
  } else {
    pushThirdError(ref, ThirdLoginError.unknown.text);
    throw ExecAction();
  }
}

Future<void> pushThirdError(Ref ref, String text, {int? time}) async {
  ref.read(loadingProvider.notifier).dismissLoading();
  ref.read(authThirdErrorMsgProvider.notifier).update((state) => text);
  Timer(Duration(seconds: time ?? 5), () {
    ref.refresh(authThirdErrorMsgProvider);
  });
}

Future<void> pushEmailError(Ref ref, String text) async {
  ref.read(loadingProvider.notifier).dismissLoading();
  ref.read(authEmailErrorMsgProvider.notifier).update((state) => text);
  Timer(Duration(seconds: 5), () {
    ref.refresh(authEmailErrorMsgProvider);
  });
}

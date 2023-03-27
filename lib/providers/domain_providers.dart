import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/pages/billing/billing_page.dart';
import 'package:flutter_template/pages/root/root_page.dart';
import 'package:flutter_template/pages/setting/setting_page.dart';
import 'package:uuid/uuid.dart';

final tokenProvider = StateProvider<String>((ref) => '');

/// 各のインスタンスを保持するプロバイダ
final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);

final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);

final firebaseMessagingProvider = Provider((_) => FirebaseMessaging.instance);

final uuidProvider = Provider((ref) => Uuid());

final camerasProvider = StateProvider((ref) => []);

/// ページ遷移のプロバイダ
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => RootPage(),
        routes: [
          GoRoute(
            path: 'setting',
            builder: (context, state) => const SettingPage(),
          ),
          GoRoute(
            path: 'billing',
            builder: (context, state) => const BillingPage(),
          ),
        ],
      ),
    ],
  ),
);

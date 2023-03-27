import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/functions/foreground_notification.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/environment/environment.dart';
import 'package:flutter_template/providers/domain_providers.dart';
import 'package:flutter/services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("バックグラウンドでメッセージを受け取りました");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 広告の初期化
  MobileAds.instance.initialize();

  /// 環境の取得
  const flavorName = String.fromEnvironment('flavor');
  final flavor =
      Flavor.values.byName(flavorName.isNotEmpty ? flavorName : 'prod');

  ///firebaseの初期化
  await Firebase.initializeApp(
    options: firebaseOptionsWithFlavor(flavor),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// 課金の初期化
  final revenueCatAPIKey = Platform.isAndroid
      ? 'goog_aVLCPfmiPOdHxuEaEYdxbovRtVQ'
      : 'appl_XetsMIHlkRUZghlkkTmSzDgooHY';
  await Purchases.setLogLevel(LogLevel.debug);
  final configuration = PurchasesConfiguration(revenueCatAPIKey);
  await Purchases.configure(configuration);
  await Purchases.enableAdServicesAttributionTokenCollection();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) => runApp(ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  void initState() {
    super.initState();

    ///利用可能なカメラの取得
    availableCameras().then(
        (value) => ref.read(camerasProvider.notifier).update((state) => value));

    ///フォアグラウンドの通知受信
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      foregroundNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _router = ref.watch(routerProvider);
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', ''),
        Locale('en', ''),
      ],
      theme: ThemeData(
        primaryColor: ColorConstant.black100,
        fontFamily: 'NotoSans',
        dividerColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      builder: EasyLoading.init(),
    );
  }
}

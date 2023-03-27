import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/data/preferences_data_source.dart';
import 'package:flutter_template/providers/domain_providers.dart';

final settingRepositoryProvider =
    Provider<SettingRepository>((ref) => SettingRepository(ref: ref));

class SettingRepository {
  SettingRepository({required this.ref});

  final Ref ref;

  ///
  /// Notification
  ///

  /// 通知用トークン作成
  Future<void> generateFCMToken() async {
    if (ref.read(tokenProvider) == '') {
      final token = await ref.read(firebaseMessagingProvider).getToken();
      ref.read(tokenProvider.notifier).update((state) => token ?? '');
    }
  }

  Future<void> requestNotificationPermission() async {
    final messaging = ref.read(firebaseMessagingProvider);
    messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  ///
  /// launch
  ///

  Future<void> launched() async {
    await ref.read(preferencesProvider).setBool(PrefKey.isLaunched.name, true);
  }

  Future<bool> getIsLaunched() async {
    final value =
        await ref.read(preferencesProvider).getBool(PrefKey.isLaunched.name);
    return value ?? false;
  }
}

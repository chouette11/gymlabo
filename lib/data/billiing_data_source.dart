import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum BillingIdentifier {
  monthly('com.flutter.template');
  const BillingIdentifier(this.value);

  final String value;
}

final billingProvider =
    Provider<BillingDataSource>((ref) => BillingDataSource(ref: ref));

class BillingDataSource {
  BillingDataSource({required this.ref});

  final Ref ref;

  /// 顧客の情報を取得
  Future<CustomerInfo> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } on PlatformException catch (e) {
      print('Error purchasing promoted product: ${e.message}');
      throw Exception();
    }
  }

  /// 課金の復元
  Future<CustomerInfo> restore() async {
    try {
      return await Purchases.restorePurchases();
    } on PlatformException catch (e) {
      print('Error restore: ${e.message}');
      throw Exception();
    }
  }

  /// 月額の課金購入
  Future<CustomerInfo?> buyMonthly() async {
    try {
      final offerings = await Purchases.getOfferings();
      final package = offerings.current!.monthly;
      if (package == null) {
        return null;
      }
      return await Purchases.purchasePackage(package);
    } on PlatformException catch (e) {
      print('Error purchasing promoted product: ${e.message}');
      throw Exception();
    }
  }
}

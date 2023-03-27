import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/primary_button.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/data/billiing_data_source.dart';
import 'package:flutter_template/pages/setting/components/setting_appbar.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/utils/context_extension.dart';

class BillingPage extends ConsumerWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProUserProvider);
    return Scaffold(
      appBar: SettingAppbar(isBilling: true),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/app_icon.png'),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  context.l10n.premium_service,
                  style: TextStyleConstant.bold24,
                ),
              ],
            ),
            SizedBox(height: 36),
            _Item(
              title: context.l10n.no_ads,
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.block, size: 48),
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'A',
                        style: TextStyle(
                          fontSize: 24,
                          color: ColorConstant.black40,
                        ),
                      ),
                      TextSpan(
                        text: 'd',
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorConstant.black40,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _Item(
              title: context.l10n.theme_color_setting,
              icon: Icon(
                Icons.color_lens,
                size: 48,
              ),
            ),
            SizedBox(height: 36),
            isPro.when(
              data: (data) {
                if (data) {
                  return Text(
                    context.l10n.registered,
                    style: TextStyleConstant.bold16,
                  );
                } else {
                  return PrimaryFilledButton(
                    context.l10n.pricePerMonth,
                    onPressed: () async {
                      ref.read(loadingProvider.notifier).showLoading();
                      await ref.read(billingProvider).buyMonthly();
                      ref.refresh(isProUserProvider);
                      ref.read(loadingProvider.notifier).dismissLoading();
                    },
                  );
                }
              },
              error: (_, __) => Text(context.l10n.error),
              loading: () => SizedBox.shrink(),
            ),
            SizedBox(height: 8),
            Text(
              context.l10n.autoRenewalNotice,
              style: TextStyleConstant.normal14
                  .copyWith(color: ColorConstant.black40),
              overflow: TextOverflow.clip,
            ),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.icon, required this.title})
      : super(key: key);
  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(
          title,
          style: TextStyleConstant.normal20,
        )
      ],
    );
  }
}

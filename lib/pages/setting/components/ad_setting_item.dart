import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/ad/setting_ad.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/providers/presentation_providers.dart';

class AdSettingItem extends ConsumerWidget {
  const AdSettingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProUserProvider);
    return isPro.when(
      data: (data) {
        if (data) {
          return SizedBox.shrink();
        }
        return Container(
          // 色の設定によりGestureDetectorが機能する
          color: Colors.transparent,
          margin: EdgeInsets.only(right: 16, left: 16),
          height: 64,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                      fontSize: 20,
                      color: ColorConstant.black40,
                    ),
                  ),
                  TextSpan(
                    text: 'd',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.black40,
                    ),
                  ),
                ]),
              ),
              SizedBox(width: 24),
              SettingAd()
            ],
          ),
        );
      },
      error:(_, __) => SizedBox.shrink(),
      loading: () =>  SizedBox.shrink(),
    );
  }
}

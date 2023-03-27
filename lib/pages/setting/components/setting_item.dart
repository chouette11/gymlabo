import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/pages/setting/components/ad_setting_item.dart';
import 'package:flutter_template/pages/setting/components/setting_user_item.dart';

class SettingItem extends ConsumerWidget {
  const SettingItem({Key? key,
    required this.title,
    required this.route,
    required this.icon,
    required this.desc})
      : super(key: key);
  final String title;
  final IconData icon;
  final String desc;
  final String route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (title == 'ad') {
      return AdSettingItem();
    } else if (title == 'user') {
      return SettingUserItem();
    } else {
      return GestureDetector(
        onTap: () => context.push(route),
        child: Container(
          // 色の設定によりGestureDetectorが機能する
          color: Colors.transparent,
          margin: EdgeInsets.only(right: 16, left: 16),
          height: 64,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width - 96,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleConstant.normal16,
                    ),
                    Visibility(
                      visible: desc != "",
                      child: Text(
                        desc,
                        style: TextStyleConstant.normal14
                            .copyWith(color: ColorConstant.black40),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

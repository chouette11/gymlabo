import 'package:flutter/material.dart';
import 'package:flutter_template/component/ad/banner_ad.dart';

class SettingAd extends StatelessWidget {
  const SettingAd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 96,
      child: BottomAd(
        width: (MediaQuery.of(context).size.width - 96).toInt(),
        height: 64,
      ),
    );
  }
}

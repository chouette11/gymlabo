import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_template/component/ad/ad_state.dart';

class BottomAd extends StatefulWidget {
  const BottomAd({Key? key, required this.width, required this.height})
      : super(key: key);
  final int width;
  final int height;

  @override
  _BottomAdState createState() => _BottomAdState();
}

class _BottomAdState extends State<BottomAd> {
  late BannerAd _ad;

  @override
  void initState() {
    super.initState();
    final AdSize adSize = AdSize(width: widget.width, height: widget.height);

    _ad = BannerAd(
      adUnitId: unitId(AdState.bannerAdUnitId),
      size: adSize,
      request: AdRequest(),
      listener: AdState.bannerListener,
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ad.size.width.toDouble(),
      height: _ad.size.height.toDouble(),
      child: AdWidget(ad: _ad),
    );
  }
}

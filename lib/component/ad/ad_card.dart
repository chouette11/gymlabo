import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/ad/banner_ad.dart';
import 'package:flutter_template/utils/context_extension.dart';

class AdCard extends ConsumerWidget {
  const AdCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: BottomAd(
          width: context.screenWidth.toInt() - 32,
          height: 92,
        ),
      ),
    );
  }
}

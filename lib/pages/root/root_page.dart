import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/pages/setting/setting_page.dart';
import 'package:flutter_template/pages/top/top_page.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/utils/context_extension.dart';

class RootPage extends ConsumerWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(topTabIndexProvider);
    final pages = [TopPage(), SettingPage()];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorConstant.black100,
          selectedItemColor: ColorConstant.purple40,
          unselectedItemColor: Color(0xFF605D62),
          onTap: (index) =>
              ref.read(topTabIndexProvider.notifier).update((state) => index),
          currentIndex: state,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                label: context.l10n.home,
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
              label: context.l10n.setting,
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: pages[state],
        ),
      ),
    );
  }
}

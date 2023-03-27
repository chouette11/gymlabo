import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/text_field_dialog.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';

class KeyboardButton extends ConsumerWidget {
  const KeyboardButton(this.ticker, {Key? key}) : super(key: key);
  final TickerProvider ticker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      width: 48,
      child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: TextFieldDialog(),
              );
            },
          );
          ref.read(animationControllerProvider(ticker)).reverse();
          ref
              .watch(isOpenFloatingButtonProvider.notifier)
              .update((state) => !state);
        },
        backgroundColor: ColorConstant.purple40,
        child: Icon(
          Icons.keyboard,
          color: ColorConstant.black100,
        ),
      ),
    );
  }
}

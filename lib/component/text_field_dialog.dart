import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/utils/constants/text_style_constant.dart';
import 'package:flutter_template/entity/task/task_entity.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'package:flutter_template/repositories/task_repository.dart';
import 'package:flutter_template/utils/context_extension.dart';

class TextFieldDialog extends ConsumerWidget {
  const TextFieldDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(textControllerProvider);
    final isError = ref.watch(isTextErrorProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: isError,
            child: Text(
              context.l10n.noTextField,
              style:
                  TextStyleConstant.bold12.copyWith(color: ColorConstant.red),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: controller,
            onFieldSubmitted: (value) => ref
                .read(taskRepositoryProvider)
                .addTask(TaskEntity.create(ref, value)),
            autofocus: true,
            cursorColor: ColorConstant.black0,
            decoration: InputDecoration(
              hintText: context.l10n.task,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstant.purple40,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstant.purple40,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}

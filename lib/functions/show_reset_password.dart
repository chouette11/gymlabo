import 'package:flutter/material.dart';
import 'package:flutter_template/functions/open_email_app.dart';
import 'package:flutter_template/utils/context_extension.dart';

Future<void> showResetPasswordDialog(String email, BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${email + context.l10n.passwordEmailSent}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => openMailApp(),
                child: Text(context.l10n.open),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
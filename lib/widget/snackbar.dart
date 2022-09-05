import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flushbar.dart';

Future<void> showErrorSnackbar(BuildContext context, String message) async{
  final theme = Theme.of(context);
  var bar = await FlushbarCustom.buildFlushbar(
      title: message, backgroundColor: Color(0xfffadbdb).withOpacity(1),
      textColor: theme.colorScheme.secondary, context: context);
  bar.show(context);
}

Future<void> showSuccessSnackbar(BuildContext context, String message) async{
  final theme = Theme.of(context);
  var bar = await FlushbarCustom.buildFlushbar(
      title: message, backgroundColor: theme.colorScheme.primary,
      textColor: Colors.white, context: context,
  );
  bar.show(context);
}

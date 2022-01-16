// ignore: todo
// TODO: Function for close keyboard

import 'package:flutter/material.dart';

void closeKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null)
    FocusManager.instance.primaryFocus!.unfocus();
}

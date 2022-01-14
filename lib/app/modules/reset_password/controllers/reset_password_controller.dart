import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailController =
      TextEditingController(text: 'diajarkoding@gmail.com');

  @override
  void onClose() {
    emailController.dispose();

    super.onClose();
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  TextEditingController emailController =
      TextEditingController(text: 'diajarkoding@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: '12345678');
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

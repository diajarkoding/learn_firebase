import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
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

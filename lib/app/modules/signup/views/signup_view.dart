import 'package:firebase/app/controllers/auth_controller.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                authController.signup(controller.emailController.text,
                    controller.passwordController.text);
              },
              child: Text('Daftar'),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sudah punya akun ?'),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Login'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

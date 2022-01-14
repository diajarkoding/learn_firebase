import 'package:firebase/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
            title: 'Verifikasi Email',
            middleText:
                'Kamu harus verifikasi email terlebih dahulu, kirim ulang verifikasi email ?',
            onConfirm: () async {
              await myUser.user!.sendEmailVerification();
              Get.back();
            },
            textConfirm: 'Kirim',
            textCancel: 'Tidak');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(title: 'Info', middleText: 'Email tidak terdaftar');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
            title: 'Info', middleText: 'Password yang anda masukan salah');
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void signup(String email, String password) async {
    try {
      UserCredential myUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
        title: 'Verifikasi Email',
        middleText: 'Kami telah mengirim email verifikasi ke $email',
        textConfirm: 'Ya, saya akan cek email',
        onConfirm: () {
          Get.back();
          Get.back();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
            title: 'Terjadi Kesalahan',
            middleText: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.defaultDialog(
            title: 'Terjadi Kesalahan',
            middleText: 'The password provided is too weak.');
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
          title: 'Terjadi Kesalahan', middleText: 'Terjadi kesalahan');
    }
  }

  void resetPassword(String email) async {
    if (email != '' && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
            title: 'Berhasil',
            middleText:
                'Kami telah mengirim permintaan reset password ke $email',
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: 'Ya, Saya mengerti');
      } catch (e) {
        Get.defaultDialog(
            title: 'Info',
            middleText: 'Tidak dapat mengirim permintaan reset password');
      }
    } else {
      Get.defaultDialog(title: 'Info', middleText: 'Email tidak valid');
    }
  }
}

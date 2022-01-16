import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference notes = firestore.collection("notes");

class AddNoteController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descController;

  void addNote(String title, String description) async {
    try {
      String dateNow = DateTime.now().toString();
      await notes
          .add({'title': title, 'description': description, 'time': dateNow});

      // Get.defaultDialog(
      //   title: 'Berhasil',
      //   middleText: 'Berhsail menambah note',
      //   onConfirm: () {
      //     titleController.clear();
      //     descController.clear();
      //     Get.back();
      //     Get.back();
      //   },
      //   textConfirm: 'Ya',
      // );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Info',
        middleText: 'Gagal menambah note',
        onConfirm: () => Get.back(),
        textConfirm: 'Ya',
      );
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    descController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    super.onClose();
  }
}

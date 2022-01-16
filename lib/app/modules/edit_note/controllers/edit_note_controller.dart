import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference notes = firestore.collection("notes");

class EditNoteController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descController;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = notes.doc(docID);
    return docRef.get();
  }

  void editNote(String title, String description, String docID) async {
    DocumentReference docData = notes.doc(docID);
    try {
      await docData.update({
        'title': title,
        'description': description,
      });

      // Get.defaultDialog(
      //   title: 'Berhasil',
      //   middleText: 'Berhsail mengubah note',
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
        middleText: 'Gagal mengubah note',
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

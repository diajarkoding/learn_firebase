import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/closeKeyboard.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Note'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;

              controller.titleController.text = data['title'];
              controller.descController.text = data['description'];

              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Text(
                    'Judul',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.descController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.editNote(
                          controller.titleController.text,
                          controller.descController.text,
                          Get.arguments,
                        );
                        closeKeyboard(context);
                        Get.back();
                      },
                      child: Text('Tambah Note'),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

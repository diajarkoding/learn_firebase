import 'package:firebase/utils/closeKeyboard.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
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
                controller.addNote(
                  controller.titleController.text,
                  controller.descController.text,
                );
                closeKeyboard(context);
                Get.back();
              },
              child: Text('Tambah Note'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/controllers/auth_controller.dart';
import 'package:firebase/app/data/models/note_model.dart';
import 'package:firebase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authC.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      // ignore: todo
      // TODO: One Time Read Data From Cloud Firestore With Model
      // body: FutureBuilder<List<NotesModel>>(
      //   future: controller.fetchData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       print(snapshot.data);
      //       final listNote = snapshot.data;
      //       return ListView.builder(
      //           itemCount: listNote!.length,
      //           itemBuilder: (context, index) {
      //             var title = listNote[index].title;
      //             var description = listNote[index].description;
      //             return Padding(
      //               padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      //               child: Card(
      //                 child: ListTile(
      //                   title: Text(title),
      //                   subtitle: Text(description),
      //                 ),
      //               ),
      //             );
      //           });
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),

      // ignore: todo
      // TODO: One Time Read Data From Cloud Firestore
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //   future: controller.getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       print(snapshot.data);
      //       final listNote = snapshot.data!.docs;

      //       return ListView.builder(
      //           itemCount: listNote.length,
      //           itemBuilder: (context, index) {
      //             var title =
      //                 (listNote[index].data() as Map<String, dynamic>)['title'];
      //             var description = (listNote[index].data()
      //                 as Map<String, dynamic>)['description'];
      //             return Padding(
      //               padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      //               child: Card(
      //                 child: ListTile(
      //                   title: Text(title),
      //                   subtitle: Text(description),
      //                 ),
      //               ),
      //             );
      //           });
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),

      // ignore: todo
      // TODO: Realtime Read Data From Cloud Firestore
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print(snapshot.data);
            final listNote = snapshot.data!.docs;

            return ListView.builder(
                itemCount: listNote.length,
                itemBuilder: (context, index) {
                  var title =
                      (listNote[index].data() as Map<String, dynamic>)['title'];
                  var description = (listNote[index].data()
                      as Map<String, dynamic>)['description'];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_NOTE,
                              arguments: listNote[index].id);
                        },
                        title: Text(title),
                        subtitle: Text(description),
                        trailing: IconButton(
                            onPressed: () {
                              controller.deleteNote(listNote[index].id);
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.ADD_NOTE);
        },
      ),
    );
  }
}

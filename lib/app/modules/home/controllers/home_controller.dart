import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/data/models/note_model.dart';
import 'package:get/get.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference notes = firestore.collection("notes");

class HomeController extends GetxController {
  Future<QuerySnapshot<Object?>> getData() {
    return notes.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    return notes.orderBy('time', descending: true).snapshots();
  }

  Future<List<NotesModel>> fetchData() async {
    try {
      QuerySnapshot result = await notes.get();
      List<NotesModel> data = result.docs.map((e) {
        return NotesModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return data;
    } catch (e) {
      throw Exception('Gagal mengambil data');
    }
  }

  void deleteNote(String docID) {
    DocumentReference docRef = notes.doc(docID);
    try {
      Get.defaultDialog(
          title: 'Konfirmasi',
          middleText: 'Anda yakin ingin menghapus note ?',
          textConfirm: 'ya',
          onConfirm: () {
            docRef.delete();
            Get.back();
          },
          textCancel: 'tidak');
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: 'Info',
        middleText: 'Note gagal dihapus',
      );
    }
  }
}

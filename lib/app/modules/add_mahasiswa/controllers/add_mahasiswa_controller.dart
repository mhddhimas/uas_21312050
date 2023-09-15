import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController cNPM;
  late TextEditingController cNama;
  late TextEditingController cAlamat;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void tambahProduk(
    String npm,
    String nama,
    String alamat,
  ) async {
    CollectionReference mahasiswa = firestore.collection("mahasiswa");

    try {
      await mahasiswa.add({
        "npm": npm,
        "nama": nama,
        "alamat": alamat,
      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menyimpan data mahasiswa",
        onConfirm: () {
          cNPM.clear();
          cNama.clear();
          cAlamat.clear();

          Get.back();
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    cNPM = TextEditingController();
    cNama = TextEditingController();
    cAlamat = TextEditingController();
  }

  @override
  void onClose() {
    cNPM.dispose();
    cNama.dispose();
    cAlamat.dispose();

    super.onClose();
  }
}

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah mahasiswa'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: controller.cNPM,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "NPM"),
            ),
            TextField(
              controller: controller.cNama,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: controller.cAlamat,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Alamat"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => controller.tambahProduk(controller.cNPM.text,
                  controller.cNama.text, controller.cAlamat.text),
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: AddProductView(),
  ));
}

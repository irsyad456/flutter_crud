import 'package:crud/masyarakat/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud/controller/Masyarakatcontroller.dart';
import 'package:crud/model/masyarakatmodel.dart';

class UpdateData extends StatelessWidget {
  final Masyarakatcontroller masyarakatcontroller = Get.find();
  final MasyarakatModel masyarakat;

  UpdateData(this.masyarakat, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addDataNik = TextEditingController(text: masyarakat.nik);
    TextEditingController addNama = TextEditingController(text: masyarakat.nama);
    TextEditingController addUsername = TextEditingController(text: masyarakat.username);
    TextEditingController addTelp = TextEditingController(text: masyarakat.telp);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextFormField(
              controller: addDataNik,
              decoration: const InputDecoration(
                labelText: 'Nik',
                // ...
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: addNama,
              decoration: const InputDecoration(
                labelText: 'Nama',
                // ...
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: addUsername,
              decoration: const InputDecoration(
                labelText: 'Username',
                // ...
              ),
            ),
            // SizedBox(height: 8,),
            // TextFormField(
            //   controller: addPasword,
            //   decoration: InputDecoration(
            //     labelText: 'Password',
            //     // ...
            //   ),
            // ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: addTelp,
              decoration: const InputDecoration(
                labelText: 'Telepon',
                // ...
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final data = {
                  'nik': addDataNik.text,
                  'nama': addNama.text,
                  'username': addUsername.text,
                  // 'password': addUsername.text,
                  'telp': addTelp.text
                };
                Masyarakatcontroller().updateData(data, addDataNik.text).then((value) =>
                Get.off(const HomePage()));

                // Di sini, Anda dapat menyimpan data ke Masyarakatcontroller jika diperlukan.
              },
              child: const Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}

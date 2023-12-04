import 'dart:convert';

import 'package:crud/controllers/DataController.dart';
import 'package:crud/provider/Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Index extends GetView<DataController> {
  List<TextEditingController> nikControllers = List.generate(DataController().masyarakatList.length, (index) => TextEditingController());
  TextEditingController nikField = TextEditingController();
  TextEditingController namaField = TextEditingController();
  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  TextEditingController telpField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index CRUD'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Obx(() => controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.masyarakatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final masyarakat =
                            controller.masyarakatList.value[index];
                        return ListTile(
                            leading: CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  Provider().deleteMasyarakat(masyarakat.nik);
                                  controller.masyarakatList.removeWhere(
                                      (data) => data.nik == masyarakat.nik);
                                },
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                            title: Text('Nama: ${masyarakat.nama}'),
                            subtitle: Text(
                                'NIK: ${masyarakat.nik}, Telp: ${masyarakat.telp}'),
                            trailing: IconButton(
                                onPressed: () {
                                  nikField.text = masyarakat.nik ?? '';
                                  namaField.text = masyarakat.nama ?? '';
                                  usernameField.text = masyarakat.username ?? '';
                                  telpField.text = masyarakat.telp ?? '';
                                  Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: 'Update Masyarakat',
                                  radius: 10, // Adjust the radius for rounded corners
                                  content: Padding(
                                    padding: const EdgeInsets.all(
                                        20), // Add some padding for better spacing
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize
                                          .min, // Ensure that the dialog fits its content
                                      children: [
                                        TextField(
                                          controller: nikField,
                                          decoration: InputDecoration(
                                            labelText: 'NIK',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 12), // Add spacing between fields
                                        TextField(
                                          controller: namaField,
                                          decoration: InputDecoration(
                                            labelText: 'Nama',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: usernameField,
                                          decoration: InputDecoration(
                                            labelText: 'Username',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: telpField,
                                          decoration: InputDecoration(
                                            labelText: 'Telp',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  textCancel: 'Cancel',
                                  textConfirm: 'Add',
                                  onCancel: () {nikField.clear();namaField.clear();usernameField.clear();telpField.clear(); Get.back();},
                                  onConfirm: () {
                                    Provider().updateMasyarakat(nikField.text, namaField.text, usernameField.text, telpField.text);
                                    nikField.clear();namaField.clear();usernameField.clear();telpField.clear();
                                    Get.back();
                                  },
                                );}, icon: Icon(Icons.edit))
                            // Text('Telp: ${controller.masyarakatList.value[index].telp}'),
                            );
                      },
                    )),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Get.defaultDialog(
                      barrierDismissible: false,
                      title: 'Add Masyarakat',
                      radius: 10, // Adjust the radius for rounded corners
                      content: Padding(
                        padding: const EdgeInsets.all(
                            20), // Add some padding for better spacing
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize
                              .min, // Ensure that the dialog fits its content
                          children: [
                            TextField(
                              controller: nikField,
                              decoration: InputDecoration(
                                labelText: 'NIK',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                                height: 12), // Add spacing between fields
                            TextField(
                              controller: namaField,
                              decoration: InputDecoration(
                                labelText: 'Nama',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: usernameField,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: passwordField,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true, // Hide the password text
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: telpField,
                              decoration: InputDecoration(
                                labelText: 'Telp',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      textCancel: 'Cancel',
                      textConfirm: 'Add',
                      onCancel: () => Get.back(),
                      onConfirm: () async {
                        final newData = Masyarakat(
                            nik: nikField.text,
                            nama: namaField.text,
                            username: usernameField.text,
                            telp: telpField.text);
                        Provider().postMasyarakat(
                            nikField.text,
                            namaField.text,
                            usernameField.text,
                            passwordField.text,
                            telpField.text);
                        controller.insertMasyarakat(newData);
                        nikField.clear();
                        namaField.clear();
                        usernameField.clear();
                        passwordField.clear();
                        telpField.clear();
                        Get.back();
                      },
                    ),
                child: const Text('Add Masyarakat'))
          ],
        ),
      ),
    );
  }
}

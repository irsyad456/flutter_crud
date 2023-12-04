import 'package:crud/controller/petugas_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ViewPetugas extends StatelessWidget {
  const ViewPetugas({super.key});

  @override
  Widget build(BuildContext context) {
    PetugasController petugas = Get.put(PetugasController());
    List<String> level = ['admin', 'petugas'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Petugas'),
          actions: [
            IconButton(
                onPressed: () => Get.defaultDialog(
                    barrierDismissible: false,
                    title: 'Add Petugas',
                    radius: 10,
                    textConfirm: 'Add',
                    onCancel: () {
                      petugas.resetFields();
                      Get.back();
                    },
                    content: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: petugas.namaField,
                            decoration: const InputDecoration(
                                labelText: 'Nama Petugas',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: petugas.usernameField,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: petugas.telpField,
                            decoration: const InputDecoration(
                                labelText: 'No Telp',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            obscureText: true,
                            controller: petugas.passwordField,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField(
                            value: petugas.selectedLevel.value,
                            items: level
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              petugas.selectedLevel.value = newValue!;
                            },
                            decoration: InputDecoration(
                                labelText: 'Level',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2))),
                          )
                        ],
                      ),
                    ),
                    onConfirm: () async {
                      final data = {
                        'id': petugas,
                        'nama_petugas': petugas.namaField.text,
                        'username': petugas.usernameField.text,
                        'telp': petugas.telpField.text,
                        'pass': petugas.passwordField.text,
                        'level': petugas.selectedLevel.value
                      };
                      petugas.postPetugas(data);
                      petugas.resetFields();
                    }),
                icon: const Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 555,
                child: Obx(() => petugas.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: petugas.petugasList.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = petugas.petugasList.value[index];

                          return ListTile(
                            leading: CircleAvatar(
                              child: Text('${data.id}'),
                            ),
                            title: Text('Name : ${data.namaPetugas}'),
                            subtitle: Text('Level: ${data.level}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      petugas.namaField.text =
                                          data.namaPetugas ?? '';
                                      petugas.usernameField.text =
                                          data.username ?? '';
                                      petugas.telpField.text = data.telp ?? '';
                                      petugas.selectedLevel.value =
                                          data.level ?? '';
                                      Get.defaultDialog(
                                          barrierDismissible: false,
                                          title: 'Update Petugas',
                                          radius: 10,
                                          onCancel: () {
                                            petugas.resetFields();
                                            Get.back();
                                          },
                                          content: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: petugas.namaField,
                                                  decoration: const InputDecoration(
                                                      labelText: 'Nama',
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                                const SizedBox(height: 10),
                                                TextField(
                                                  controller:
                                                      petugas.usernameField,
                                                  decoration: const InputDecoration(
                                                      labelText: 'Username',
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                                const SizedBox(height: 10),
                                                TextField(
                                                  controller: petugas.telpField,
                                                  decoration: const InputDecoration(
                                                      labelText: 'No.Telp',
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                                const SizedBox(height: 10),
                                                DropdownButtonFormField(
                                                  value: petugas
                                                      .selectedLevel.value,
                                                  items: level.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    petugas.selectedLevel
                                                        .value = newValue!;
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Level',
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .amber,
                                                                      width:
                                                                          2))),
                                                )
                                              ],
                                            ),
                                          ),
                                          onConfirm: () {
                                            final json = {
                                              'id' : data.id,
                                              'nama_petugas':
                                                  petugas.namaField.text,
                                              'username':
                                                  petugas.usernameField.text,
                                              'telp': petugas.telpField.text,
                                              'level':
                                                  petugas.selectedLevel.value
                                            };
                                            petugas.updatePetugas(
                                                json, data.id!.toString());
                                            petugas.resetFields();
                                          });
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'Confirm Deletion',
                                      middleText:
                                          'Are you sure you want to delete this item?',
                                      radius:
                                          10.0, // Set the border radius of the dialog
                                      contentPadding: const EdgeInsets.all(
                                          20.0), // Set padding for the content
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            petugas.deletePetugas(
                                                data.id!.toString());
                                            Get.back(); // Close the dialog
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .red, // Change the background color of the button
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back(); // Close the dialog without deleting
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.indigo[100]),
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                  icon: const Icon(Icons.remove),
                                )
                              ],
                            ),
                          );
                        },
                      )),
              )
            ],
          ),
        ));
  }
}

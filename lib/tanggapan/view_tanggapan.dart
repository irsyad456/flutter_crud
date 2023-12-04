import 'package:crud/controller/tanggapan_controller.dart';
import 'package:crud/model/pengaduan_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ViewTanggapan extends StatelessWidget {
  const ViewTanggapan({super.key});

  @override
  Widget build(BuildContext context) {
    TanggapanController tanggapan = Get.put(TanggapanController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Tanggapan'),
          actions: [
            IconButton(
                onPressed: () => Get.defaultDialog(
                    barrierDismissible: false,
                    title: 'Add Tanggapan',
                    radius: 10,
                    textConfirm: 'Add',
                    onCancel: () {
                      tanggapan.resetFields();
                      Get.back();
                    },
                    content: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: tanggapan.idPengaduanField,
                            decoration: const InputDecoration(
                                labelText: 'Id Pengaduan',
                                hintText: 'Id Ada Di view pengaduan',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: tanggapan.tanggapanField,
                            decoration: const InputDecoration(
                                labelText: 'Isi Tanggapan',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 12)
                        ],
                      ),
                    ),
                    onConfirm: () async {
                      final data = {
                        'tanggapan' : tanggapan.tanggapanField.text,
                        'id_pengaduan' : tanggapan.idPengaduanField.text
                      };
                      tanggapan.postTanggapan(data, tanggapan.idPengaduanField.text);
                      tanggapan.resetFields();
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
                child: Obx(() => tanggapan.loading.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  itemCount: tanggapan.tanggapanList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = tanggapan.tanggapanList.value[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${data.id}'),
                      ),
                      title: Text('Tanggapan : ${data.tanggapan}'),
                      subtitle: Text('Tanggal Tanggapan: ${data.tglTanggapan}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                tanggapan.tanggapanField.text = data.tanggapan ?? '';
                                Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: 'Update Tanggapan',
                                    radius: 10,
                                    onCancel: () {
                                      tanggapan.resetFields();
                                      Get.back();
                                    },
                                    content: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 12),
                                          TextField(
                                            controller: tanggapan.tanggapanField,
                                            decoration: const InputDecoration(
                                                labelText: 'Isi Tanggapan',
                                                border:
                                                OutlineInputBorder()),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onConfirm: () {
                                      final json = {
                                        'id' : data.id,
                                        'id_pengaduan' : data.idPengaduan,
                                        'tgl_tanggapan' : data.tglTanggapan,
                                        'tanggapan' : tanggapan.tanggapanField.text
                                      };
                                      tanggapan.updateTanggapan(
                                          json, data.id!.toString());
                                      tanggapan.resetFields();
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
                                      tanggapan.deleteTanggapan(
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

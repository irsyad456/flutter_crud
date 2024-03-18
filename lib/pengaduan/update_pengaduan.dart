import 'dart:typed_data';
import 'package:crud/controller/pengaduan_controller.dart';
import 'package:crud/controller/upload_image_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class UpdatePengaduan extends StatelessWidget {
  String? isiLaporan;
  String? image;
  String? tglPengaduan;
  String? url;
  int? id;
  UpdatePengaduan({super.key, this.isiLaporan, this.image, this.id, this.tglPengaduan, this.url});

  @override
  Widget build(BuildContext context) {
    PengaduanController controller = Get.find<PengaduanController>();
    UploadImageController imageController = Get.put(UploadImageController());
    controller.isiLaporanField.text = isiLaporan ?? '';
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Pengaduan'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.isiLaporanField,
                decoration: InputDecoration(
                    labelText: 'Isi Laporan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2))),
              ),
              const SizedBox(height: 10),
              Obx(() => Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Center(
                            child: imageController.loading.value
                                ? const CircularProgressIndicator()
                                : imageController.isWeb.value
                                    ? ElevatedButton(
                                        onPressed: () {
                                          imageController.pickImageWebsite();
                                          imageController.web.value = true;
                                        },
                                        child: const Text('Pick Image'))
                                    : ElevatedButton(
                                        onPressed: () {
                                          imageController.pickImageHandphone();
                                          imageController.web.value = false;
                                        },
                                        child: const Text('Pick Image')))
                      ],
                    ),
                  )),
              Obx(() {
                return imageController.pickedImage.value != null
                    ? SizedBox(
                        width: 400,
                        height: 200,
                        child: Image.memory(
                            Uint8List.fromList(
                                imageController.pickedImage.value!.bytes!),
                            fit: BoxFit.cover),
                      )
                    : SizedBox(
                        width: 400,
                        height: 200,
                        child: Image.network(image ?? ''),
                      );
              }),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                        controller
                            .updatePengaduan(id, tglPengaduan, url)
                            .then((value) => Get.offNamed('/pengaduan'));
                      },
                  child: const Text('Update'))
            ],
          ),
        ));
  }
}

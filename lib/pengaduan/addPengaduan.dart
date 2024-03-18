import 'package:crud/controller/pengaduan_controller.dart';
import 'package:crud/controller/upload_image_controller.dart';
import 'package:crud/pengaduan/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPengaduan extends StatelessWidget {
  const AddPengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    Uint8List imageData = Uint8List(0);
    UploadImageController imageController = Get.put(UploadImageController());
    PengaduanController controller = Get.put(PengaduanController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pengaduan'),
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2)),
              ),
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
                                    child: const Text('Pick Image')),
                      )
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
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(
                      height: 200,
                    );
            }),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  final data = {'isi_laporan': controller.isiLaporanField.text};
                  controller
                      .postPengaduan(imageData, data)
                      .then((value) => Get.off(const Pengaduan()));
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}

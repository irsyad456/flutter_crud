import 'package:crud/controller/pengaduan_controller.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class UploadImageController extends GetxController {
  final Rx<PlatformFile?> pickedImage = Rx<PlatformFile?>(null);
  RxBool loading = false.obs;
  RxBool web = false.obs;
  File? fileInHandphone;
  Uint8List? fileInWebsite;
  var isWeb = kIsWeb.obs;

  String? selected;

  Future<void> pickImageHandphone () async {
    try {
      loading.value = true;
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if(result != null) {
        pickedImage.value = result.files.first;
        // fileInHandphone = File(pickedImage!.path.toString());
      }
      loading.value = false;
    } catch(error) {
      loading.value = false;
      if(kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<void> pickImageWebsite() async {
    try{
      loading.value = true;
      FilePickerResult? result = await FilePickerWeb.platform.pickFiles(type: FileType.image);
      if(result == null) return;

      pickedImage.value = result.files.first;
      // fileInWebsite = Uint8List.fromList(pickedImage!.bytes!);
      // if(kDebugMode) {
      //   print(pickedImage);
      // }

      loading.value = false;
    } catch(error) {
      loading.value = false;
      if(kDebugMode) {
        print(error.toString());
      }
    }
  }
}
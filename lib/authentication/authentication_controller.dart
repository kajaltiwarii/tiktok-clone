import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController
{
  static AuthenticationController instanceAuth = Get.find();

  late Rx<File?> _pickedFile;
  File? get profileImage => _pickedFile.value;

  void chooseImageFromGallery() async{
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImageFile != null)
      {
        Get.snackbar(
          "Profile Image",
          "You have successfully uploaded your profile picture"
        );
      }

    _pickedFile = Rx<File>(File(pickedImageFile!.path));

  }

  void captureImageWithCamera() async{
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(pickedImageFile != null)
    {
      Get.snackbar(
          "Profile Image",
          "you have successfully selected your profile image"
      );
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));

  }

}
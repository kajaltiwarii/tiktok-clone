import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';
import 'package:tiktok_clone/global.dart';
import 'user.dart' as userModel;

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

  void createAccountForNewUser(File imageFile, String userName, String userEmail, String userPassword) async
  {
    try{
      //1. create user in the firebase authentication
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );

      //2. save the user profile image to firebase storage
      String imageDownloanUrl = await uploadImagetoStorage(imageFile);

      //3. save user data to the firestore datebase
      userModel.User user = userModel.User(
          name: userName,
          email: userEmail,
          image: imageDownloanUrl,
          uid: credential.user!.uid
      );

      await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set(user.toJson());
    }catch(error)
    {
      Get.snackbar(error.toString(), "Error occured while creating acocunt, try again");
      print("Error --> ${error.toString()}");
      showProgressBar = false;
      Get.to(LoginScreen());
    }
  }

  Future<String> uploadImagetoStorage(File imageFile) async
  {
    Reference reference = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloanUrlOfUploadedImage = await taskSnapshot.ref.getDownloadURL();

    return downloanUrlOfUploadedImage;

  }


}
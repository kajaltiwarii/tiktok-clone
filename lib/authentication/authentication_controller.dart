import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';
import 'package:tiktok_clone/authentication/registration_screen.dart';
import 'package:tiktok_clone/global.dart';
import 'package:tiktok_clone/home/home_screen.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController
{
  static AuthenticationController instanceAuth = Get.find();
  late Rx<User?> _currentUser;

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
        _pickedFile = Rx<File>(File(pickedImageFile.path));
      }else{
      Get.snackbar(
          "Profile Image",
          "You have not uploaded your profile picture"
      );
    }

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
      String imageDownloadUrl = await uploadImagetoStorage(imageFile);

      //3. save user data to the firestore database
      userModel.User user = userModel.User(
          name: userName,
          email: userEmail,
          image: imageDownloadUrl,
          uid: credential.user!.uid
      );
      await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set(user.toJson());
      Get.snackbar("Congratulation!", "Your account is created successfully.");
      showProgressBar = false;

    }
    catch(error)
    {
      Get.snackbar("registration error occurred!", "while authentication");
      showProgressBar = false;
      Get.to(const LoginScreen());
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

  void loginUserNow(String userEmail, String userPassword) async{

    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword);

      Get.snackbar("logged in successful", "you are logged in successfully");
      showProgressBar = false;

    }catch(error)
    {
      Get.snackbar("login error occurred!", "while authentication");
      showProgressBar = false;
      Get.to(const RegistrationScreen());
    }
  }

  goToScreen(User? currentUser)
  {
    if(currentUser == null){ // if user is not already logged in
      Get.offAll(const LoginScreen());
    } else
    {
      Get.offAll(const HomeScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _currentUser =  Rx<User?>(FirebaseAuth.instance.currentUser);
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_currentUser, goToScreen);
  }
}
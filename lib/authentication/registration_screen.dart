import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/authentication/authentication_controller.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';

import '../global.dart';
import '../widgets/input_text_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
{

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text("Create Account",
                  style: GoogleFonts.abhayaLibre(
                      fontSize: 34,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),
                ),

                Text("to get Started Now!",
                  style: GoogleFonts.abhayaLibre(
                      fontSize: 34,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 30),

                //profile avatar
                GestureDetector(
                  onTap: ()  // allow user to choose image
                  {
                    authenticationController.chooseImageFromGallery();
                  },
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("images/profile_avatar.jpg"),
                    backgroundColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                      textEditingController: userNameTextEditingController,
                      lableString: "Username",
                      iconData: Icons.person_outlined,
                      isObscure: false
                  ),
                ),
                const SizedBox(height: 25),
                //email input()
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                      textEditingController: emailTextEditingController,
                      lableString: "Email",
                      iconData: Icons.email_outlined,
                      isObscure: false
                  ),
                ),
                const SizedBox(height: 25),
                //password input()
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                      textEditingController: passwordTextEditingController,
                      lableString: "Password",
                      iconData: Icons.lock,
                      isObscure: true
                  ),
                ),

                // Login button
                const SizedBox(height: 30),
                showProgressBar == false ?
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 38,
                      height: 54,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                      ),
                      child: InkWell(
                        onTap: ()
                        {
                          if(authenticationController.profileImage != null && userNameTextEditingController.text.isNotEmpty && emailTextEditingController.text.isNotEmpty && passwordTextEditingController.text.isNotEmpty)
                          {
                            setState(() {
                              showProgressBar = true;
                            });
                            //create an account for user
                            authenticationController.createAccountForNewUser(
                                authenticationController.profileImage!,
                                userNameTextEditingController.text,
                                emailTextEditingController.text.toString().trim(),
                                passwordTextEditingController.text);
                          }else{
                            if(authenticationController.profileImage == null){
                              Get.snackbar
                                (
                                  "Profile Image",
                                  "please upload profile image"
                              );
                            }
                            if(userNameTextEditingController.text.isEmpty){
                              Get.snackbar
                                (
                                  "userName",
                                  ""
                              );
                            }
                            if(emailTextEditingController.text.isNotEmpty){
                              Get.snackbar
                                (
                                  "email",
                                  ""
                              );
                            }
                            if(passwordTextEditingController.text.isEmpty){
                              Get.snackbar
                                (
                                  "password",
                                  ""
                              );
                            }
                          }
                        },
                        child: const Center(
                          child: Text("Sign Up",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(() =>(LoginScreen()));
                          },
                          child: const Text("Login Now",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ) : Container(
                  //show animations
                  child: const SimpleCircularProgressBar(
                    progressColors: [
                      Colors.green,
                      Colors.blueAccent,
                      Colors.red,
                      Colors.amber,
                      Colors.purpleAccent
                    ],
                    animationDuration: 3,
                    backColor: Colors.white38,
                  ),
                )

                // signup button



              ],
            ),
          ),
        )
    );
  }
}

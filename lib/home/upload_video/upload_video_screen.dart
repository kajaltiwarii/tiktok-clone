import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {

  displayDialogBox(){
    return showDialog(
      context: context,
      builder: (context)=> SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: (){

            },
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Get video From Gallery",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SimpleDialogOption(
            onPressed: (){

            },
            child: Row(
              children: const [
                Icon(Icons.camera),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Capture Video from Camera",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SimpleDialogOption(
            onPressed: (){
              Get.back();
            },
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            const Icon(Icons.upload, size: 200,),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  displayDialogBox();
                },
                style: ElevatedButton.styleFrom(
                  // backgroudColor: Colors.green
                ),
                child: const Text(
                  "Upload new video",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:Colors.white
                  ),
                ))

          ],
        )
      ),
    );
  }
}

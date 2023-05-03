import 'package:flutter/material.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
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

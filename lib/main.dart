import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  runApp(const APP());
}

class APP extends StatefulWidget {
  const APP({super.key});
  @override
  State<APP> createState() => MyApp();
}

class MyApp extends State<APP> {
  File? _selectedImages;
  final _imagePicker = ImagePicker();

  void handleCamera() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;

    setState(() {
      _selectedImages = File(pickedImage.path);
    });
  }

  void handleGellary() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      _selectedImages = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black38,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Camera",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: handleCamera,
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: handleGellary,
                    icon: const Icon(
                      Icons.photo_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
            Container(
              color: Colors.grey.shade800,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: _selectedImages == null
                  ? const Center(child: Text('No image selected.'))
                  : Image.file(File(_selectedImages!.path)),
            )
          ],
        ),
      ),
    );
  }
}

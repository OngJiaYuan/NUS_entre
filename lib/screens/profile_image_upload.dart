import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageUpload extends StatefulWidget {
  static String id = 'image_upload';

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [],
      ),
    );
  }
}

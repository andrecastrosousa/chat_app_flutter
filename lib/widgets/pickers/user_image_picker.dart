import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void pickImage() async {
    final pickedImageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, 
        maxWidth: 150, maxHeight: 150);
    setState(() {
      _pickedImage = pickedImageFile;
    });

    widget.imagePickFn(_pickedImage);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage): null,
        ),
        TextButton(
          onPressed: pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image),
              Text('Add Image'),
            ],
          ),
        )
      ],
    );
  }
}

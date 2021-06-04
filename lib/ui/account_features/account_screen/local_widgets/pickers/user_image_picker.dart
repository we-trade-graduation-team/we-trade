import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.imagePickFn})
      : super(key: key);

  final void Function(PickedFile pickedImage) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<void Function(PickedFile pickedImage)>(
        'imagePickFn', imagePickFn));
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  PickedFile _pickedImage = PickedFile('');

  Future<void> uploadFile(String filePath) async {
    // ignore: unused_local_variable
    UploadTask uploadTask;
    final file = File(filePath);
    // ignore: avoid_print
    print('upload ne');

    final ref = FirebaseStorage.instance
        .ref()
        .child('playground')
        .child('/some-image.jpg');
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});
    uploadTask = ref.putFile(file, metadata);
  }

  Future _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedImageFile!;
      // uploadFile(pickedImageFile.path.toString());
    });

    // final ref = FirebaseStorage.instance
    //     .ref()
    //     .child('user_image')
    //     .child('${AccountScreen.localUserID}.jpg');

    // try {
    //   await ref.putFile(File(_pickedImage.path));
    // } catch (e) {
    //   print('Loi upfile $e');
    // }
    // final tempFile = File(pickedImageFile!.path);
    // widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        // radius: 25,
        backgroundImage: FileImage(File(_pickedImage.path)),
      ),
    );
  }
}

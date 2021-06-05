import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
      {Key? key, required this.imagePickFn, required this.userID})
      : super(key: key);

  final void Function(PickedFile pickedImage) imagePickFn;
  final String userID;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<void Function(PickedFile pickedImage)>(
        'imagePickFn', imagePickFn));
    properties.add(StringProperty('userID', userID));
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  PickedFile _pickedImage = PickedFile('');

  Future<void> uploadImageFromGallery() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    await Permission.photos.request();
    final permissonStatus = await Permission.photos.status;

    if (permissonStatus.isGranted) {
      final pickedImageFile =
          (await _picker.getImage(source: ImageSource.gallery))!;
      final file = File(pickedImageFile.path);
      if (pickedImageFile.path.isNotEmpty) {
        final userID = widget.userID;
        await _storage.ref().child('user_image/$userID').putFile(file);

        setState(() {
          _pickedImage = pickedImageFile;
        });
      }
    }
  }

  Future uploadImageFromCamera() async {
    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();

    await Permission.photos.request();
    final permissonStatus = await Permission.photos.status;
    if (permissonStatus.isGranted) {
      final pickedImageFile = await picker.getImage(source: ImageSource.camera);
      final file = File(pickedImageFile!.path);
      if (pickedImageFile.path.isNotEmpty) {
        final userID = widget.userID;
        await storage.ref().child('user_image/$userID').putFile(file);
        setState(() {
          _pickedImage = pickedImageFile;
        });
      }
    }
  }

  Future uploadImage() async {
    return showMyPickerMethodDialog(
      context: context,
      mainTitle: 'Đăng ảnh lên từ',
      fromGalleryTitle: 'Thư viện ảnh',
      fromGalleryHandler: uploadImageFromGallery,
      fromCameraTitle: 'Camera',
      fromCameraHandler: uploadImageFromCamera,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: uploadImage,
      child: CircleAvatar(
        // radius: 25,
        backgroundImage: FileImage(File(_pickedImage.path)),
      ),
    );
  }
}

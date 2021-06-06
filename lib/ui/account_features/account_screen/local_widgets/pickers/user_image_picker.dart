import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils.dart';
import '../../account_screen.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('userID', userID));
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  final referenceDatabase = AccountScreen.localRefDatabase;

  PickedFile pickedUploadImage = PickedFile('');
  String firstLoadImageUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    // final _storage = FirebaseStorage.instance;

    try {
      referenceDatabase
          .collection('users')
          .doc(widget.userID)
          .get()
          .then((documentSnapshot) {
        final user = documentSnapshot.data();

        setState(() {
          firstLoadImageUrl = user!['avatarUrl'].toString();
          isLoading = false;
        });
      });
    } on FirebaseException catch (_) {}

    // _storage
    //     .ref()
    //     .child('user_image')
    //     .child(widget.userID)
    //     .getDownloadURL()
    //     .then((downloadURL) {
    //   setState(() {
    //     firstLoadImageUrl = downloadURL;
    //     isLoading = false;
    //   });
    // });
    super.initState();
  }

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
        try {
          final userID = widget.userID;
          final snapshot =
              await _storage.ref().child('user_image/$userID').putFile(file);
          setState(() {
            pickedUploadImage = pickedImageFile;
          });
          final downloadUrl = await snapshot.ref.getDownloadURL();
          await referenceDatabase
              .collection('users')
              .doc(widget.userID)
              .update({'avatarUrl': downloadUrl});
        } on FirebaseException catch (_) {
          await showMyNotificationDialog(
              context: context,
              title: 'Lỗi',
              content: 'Tải dữ liệu không thành công. Vui lòng thử lại!',
              handleFunction: () {
                Navigator.of(context).pop();
              });
        }
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
        final snapshot =
            await storage.ref().child('user_image/$userID').putFile(file);

        setState(() {
          pickedUploadImage = pickedImageFile;
        });
        final downloadUrl = await snapshot.ref.getDownloadURL();
        await referenceDatabase
            .collection('users')
            .doc(widget.userID)
            .update({'avatarUrl': downloadUrl});
      }
    }
  }

  Future uploadImage() async {
    await showMyPickerMethodDialog(
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
    return (isLoading || firstLoadImageUrl.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black26),
            ),
          )
        : GestureDetector(
            onTap: uploadImage,
            child: pickedUploadImage.path.isEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(firstLoadImageUrl, scale: 1))
                : CircleAvatar(
                    backgroundImage: FileImage(File(pickedUploadImage.path))),
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('firstLoadImageUrl', firstLoadImageUrl));
    properties.add(DiagnosticsProperty<PickedFile>(
        'pickedUploadImage', pickedUploadImage));
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading));
  }
}

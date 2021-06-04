import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

class ImageDataStorageHelper {
  // hàm này chuyển đổi từ asset ---> file để load lên
  static Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${asset.name}');
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }

// hàm này để push lên firestorage và trả ra URL để m có thể lưu vào firestore tiếp
// truyền vào folderName, và fileName muốn lưu cho ảnh đó
  static Future<String> getImageURL(
      String folderName, String fileName, Asset image) async {
    final _storage = FirebaseStorage.instance;
    final file = await getImageFileFromAssets(image);
    final snapshot =
        await _storage.ref().child('$folderName/$fileName').putFile(file);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

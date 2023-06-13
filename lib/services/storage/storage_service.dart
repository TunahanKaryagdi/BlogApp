import 'dart:io';

import 'package:blog_app/utils/storage_folder_enum.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  Future<String> uploadImage(
      XFile file, StorageFolders folder, String id) async {
    final Reference storageRef =
        FirebaseStorage.instance.ref().child(folder.name).child(id);
    //son child id olacak
    UploadTask uploadTask = storageRef.putFile(File(file.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }
}

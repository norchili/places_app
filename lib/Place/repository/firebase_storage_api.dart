import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaStorageApi {
  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<UploadTask> uploadFile(String path, File image) async {
    UploadTask storageUploadTask = _storageReference.child(path).putFile(image);
    return storageUploadTask;
  }
}

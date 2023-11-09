import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImageToStorage(
      {required String name, required File file}) async {
    //String idPost = const Uuid().v1();

    try {
      Reference ref = _storage.ref().child(name).child(const Uuid().v4());

      UploadTask uploadTask = ref.putFile(file);

      String dowloadURL = await (await uploadTask).ref.getDownloadURL();

      return dowloadURL;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

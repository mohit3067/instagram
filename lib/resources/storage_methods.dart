import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod{

FirebaseStorage storage = FirebaseStorage.instance;
FirebaseAuth auth = FirebaseAuth.instance;

Future<String> UploadImageToStorage(String childname,bool ispost,Uint8List file)async{
  
  Reference ref = storage.ref().child(auth.currentUser!.uid);

  if(ispost){
    String id = Uuid().v1();
    ref = ref.child(id); 
  }

  UploadTask uploadTask = ref.putData(file);

  TaskSnapshot snap = await uploadTask;
  String downloadurl = await snap.ref.getDownloadURL();
  return downloadurl;
}
}
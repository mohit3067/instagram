import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/models/user.dart' as model;

class Authmethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromsnap(snap);
  }

  Future<String> signUpuser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = 'some error occurred!';
    try {
      if (email.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photourl = await StorageMethod()
            .UploadImageToStorage('profilepic', false, file);

        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            photourl: photourl,
            username: username,
            bio: bio,
            follower: [],
            following: []);

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tojson());

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }
}



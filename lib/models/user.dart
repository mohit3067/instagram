import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String bio;
  final List following;
  final List follower;

  User({
    required this.email,
    required this.uid,
    required this.photourl,
    required this.username,
    required this.bio,
    required this.follower,
    required this.following,
  });


Map<String,dynamic> tojson()=>{
   'username': username,
          'uid': uid,
          'email': email,
          'bio': bio,
          'followers': follower,
          'following': following,
          'photourl': photourl,
};

static User fromsnap(DocumentSnapshot snap){
  var snapshot= snap.data() as Map<String,dynamic>;

  return User(
    username: snapshot['username'],
    bio: snapshot['bio'],
    follower: snapshot['followers'],
    following: snapshot['following'],
    email: snapshot['email'],
    uid: snapshot['uid'],
    photourl: snapshot['photourl']
  );
}
}

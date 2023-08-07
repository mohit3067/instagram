import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/addpost.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/screens/search_screen.dart';
const webScreensize= 600;

List<Widget> homescreenitem = [
         FeedScreen(),
          SearchScreen(),
          AddPostScreen(),
          Text('like'),
        ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];
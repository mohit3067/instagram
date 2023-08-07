import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provides/user_provider.dart';
import 'package:instagram/responsive/mobilescreenlayout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/webscreenlayout.dart';
// import 'package:instagram/screens/signup_screen.dart';
// import 'package:instagram/responsive/mobilescreenlayout.dart';
// import 'package:instagram/responsive/responsive_layout_screen.dart';
// import 'package:instagram/responsive/webscreenlayout.dart';
import 'screens/login_screen.dart';
import 'package:provider/provider.dart';
// import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAwulAlLZBxxRDx2QH4PzhWBcxXX_z6Jjg",
            appId: "1:739885378365:web:583d8dc5b2ea4b21daf354",
            messagingSenderId: "739885378365",
            projectId: "instagram-e80cf",
            storageBucket: "instagram-e80cf.appspot.com"));
  }
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot){
            if(snapShot.connectionState == ConnectionState.active){
              if(snapShot.hasData){
                return ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout());
              }else if (snapShot.hasError){
                return Center(child: Text('${snapShot.error}'),);
              }
            }
            if(snapShot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Colors.white),);
            }
            return LoginScreen();
          }
        ),
        // home: Signup(),
        // home: LoginScreen(),
        // home:  ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout())
      ),
    );
  }
}

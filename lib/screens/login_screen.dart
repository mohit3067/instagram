import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/mobilescreenlayout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/webscreenlayout.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/util/util.dart';
import 'package:instagram/widgets/textinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isloading= false;

@override
void dispose(){
super.dispose();
emailcontroller.dispose();
passwordcontroller.dispose();
}

void loginUser()async{
  setState(() {
    isloading=true;
  });
 String res =  await Authmethod().loginUser(email: emailcontroller.text, password: passwordcontroller.text);
 if(res== 'success'){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout())));
 }else{
showSnakBar(res, context);
 }
 setState(() {
   isloading= false;
 });
}

void navigateToSignup(){
 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              FittedBox(
                child: Container(
                  height: 500,
                  child: Image.asset('images/logo.png')),
              ),
              // SizedBox(height: 60),
              TextInputFeild(
                  textEditingController: emailcontroller,
                  hinttext: 'enter your Email',
                  textInputType: TextInputType.emailAddress),
              SizedBox(height: 15),
              TextInputFeild(
                hinttext: 'enter your password',
                textInputType: TextInputType.text,
                textEditingController: passwordcontroller,
                ispass: true,
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: isloading? Center(child: CircularProgressIndicator(color: Colors.white,)) :Text('log-in',style: TextStyle(fontSize: 18),),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(5),
                  color: Colors.blue,
                  ),
                  height: 50,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('new user?'),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(onTap: navigateToSignup,child: Text('Sign-up',style: TextStyle(fontSize: 15,color: Colors.blue),)),
                  ),
                  Text('now'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

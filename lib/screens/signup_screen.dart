import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/mobilescreenlayout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/webscreenlayout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/util/util.dart';
import 'package:instagram/widgets/textinput.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? image;
  bool isloading= false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void SignUpUser() async {
    setState(() {
      isloading=true;
    });
   String res = await Authmethod().signUpuser(
      email: emailController.text,
      password: passwordController.text,
      bio: bioController.text,
      username: usernameController.text,
      file: image!,
    );
      setState(() {
        isloading=false;
      });
    if( res == 'success'){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout())));
    }else{
showSnakBar(res, context);
    }
  }

void navigateToLogin(){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 200,
              child: Image.asset('images/logo.png'),
            ),
            Stack(
              children: [
                image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('images/logo.png'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Color.fromARGB(255, 186, 182, 174),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        TextInputFeild(
                          hinttext: 'Enter your username',
                          textEditingController: usernameController,
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(height: 15),
                        TextInputFeild(
                          textEditingController: emailController,
                          hinttext: 'Enter your email',
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 15),
                        TextInputFeild(
                          hinttext: 'Enter your password',
                          textInputType: TextInputType.text,
                          textEditingController: passwordController,
                          ispass: true,
                        ),
                        SizedBox(height: 15),
                        TextInputFeild(
                          hinttext: 'Enter your bio',
                          textEditingController: bioController,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: SignUpUser,
                          child: Container(
                            child: isloading? Center(child: CircularProgressIndicator(color: Colors.white,)) :Text(
                              'Sign-up',
                              style: TextStyle(fontSize: 18),
                            ),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                            ),
                            height: 50,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already registered then?'),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: navigateToLogin,
                                child: Text(
                                  'log-in',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Text('now'),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

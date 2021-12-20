import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../appbar.dart';
import '../bottom_nav.dart';
import '../current_route.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                child: CustomAppbar(),
                top: 0,
                right: 0,
                left: 0,
              ),
              Center(child: KeyboardVisibilityProvider(child: EditSignUp())),
              Positioned(
                child: KeyboardVisibilityProvider(child: BottomNav()),
                bottom: 0,
                right: 0,
                left: 0,
              ),
            ],
          ),
        ),
        onWillPop: () {
          currentRoute = CurrentRoute.login;
          return Future.value(true);
        },
      ),
    );
  }
}

class EditSignUp extends StatefulWidget {
  const EditSignUp({Key? key}) : super(key: key);

  @override
  _EditSignUpState createState() => _EditSignUpState();
}

class _EditSignUpState extends State<EditSignUp> {
  bool isGoogleLoginPage = true;

  final _auth = FirebaseAuth.instance;

  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Padding(
      padding:
          isKeyboardVisible ? EdgeInsets.only(top: 70.0) : EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                          color: Colors.grey)
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isGoogleLoginPage = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text("Google 가입", style: TextStyle(fontWeight: isGoogleLoginPage ? FontWeight.bold : FontWeight.normal)),
                              SizedBox(height: 3.0),
                              isGoogleLoginPage ? Container(height: 3, width: 60, color: Colors.orangeAccent,) :
                              Container(height: 3, width: 60, color: Colors.transparent,)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isGoogleLoginPage = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text("Email 가입", style: TextStyle(fontWeight: !isGoogleLoginPage ? FontWeight.bold : FontWeight.normal)),
                              SizedBox(height: 3.0),
                              !isGoogleLoginPage ? Container(height: 3, width: 60, color: Colors.orangeAccent,) :
                              Container(height: 3, width: 60, color: Colors.transparent,)
                            ],
                          ),
                        )
                      ],
                    ),
                    isGoogleLoginPage ? SignUpGoogle() : SignUpEmail()
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 30,
                  child: TextButton(onPressed: () {}, child: Text("개인정보보호정책"))),
              SizedBox(
                  height: 30,
                  child: TextButton(onPressed: () {}, child: Text("서비스이용약관")))
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpGoogle extends StatefulWidget {
  const SignUpGoogle({Key? key}) : super(key: key);

  @override
  _SignUpGoogleState createState() => _SignUpGoogleState();
}

class _SignUpGoogleState extends State<SignUpGoogle> {
  final _auth = FirebaseAuth.instance;
  TextEditingController nickname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              hintText: "닉네임",
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.all(10.0)),
            controller: nickname,
            autofocus: false,),
          SizedBox(height: 50.0),
          ButtonTheme(
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                onPressed: () async {



                  signInWithGoogle(); //가입, 로그인

                  // await GoogleSignIn().disconnect();
                  // _auth.currentUser!.delete();
                  // _auth.signOut();

                  // setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Image.asset(
                        "assets/googleicon.png",
                        height: 20.0,
                      ),
                    ),
                    Text("Google 아이디로 가입", style: TextStyle(color: Colors.black)),
                    Opacity(
                      opacity: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        child: Image.asset(
                          "assets/googleicon.png",
                          height: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          SizedBox(height:30),
          TextButton(onPressed: () async {await GoogleSignIn().disconnect();_auth.signOut();}, child: Text("로그아웃")),
          TextButton(onPressed: () async {await GoogleSignIn().disconnect();_auth.currentUser!.delete();}, child: Text("삭제"),)
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    print("okok" + googleUser.email);
    
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.0,
          ),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "닉네임",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: nickname,
            autofocus: false,
          ),
          UnderText(text: ""),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "이메일",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: email,
            autofocus: false,
          ),
          UnderText(text: ""),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "비밀번호",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: password1,
            autofocus: false,
          ),
          UnderText(text: ""),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "비밀번호 확인",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: password2,
            autofocus: false,
          ),
          UnderText(text: ""),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            onPressed: () async {
              // String uid = _auth.currentUser!.uid;
              // print(uid);
              // await _auth.currentUser!.delete();

              // try {
              //   final newUser = await _auth.createUserWithEmailAndPassword(
              //     email: email.text,
              //     password: password.text,
              //   );
              // } on FirebaseAuthException catch (e) {
              //   if (e.code == 'weak-password') {
              //     print('The password provided is too weak.');
              //   } else if (e.code == 'email-already-in-use') {
              //     print('The account already exists for that email.');
              //   }
              // } catch (e) {
              //   print(e);
              // }
            },
            child: Text("가입"),
          ),
        ],
      ),
    );
  }
}

class UnderText extends StatefulWidget {
  final String text;

  const UnderText({Key? key, required this.text}) : super(key: key);

  @override
  _UnderTextState createState() => _UnderTextState();
}

class _UnderTextState extends State<UnderText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0, left: 10.0, bottom: 5.0),
      child: Row(
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 15, color: Colors.red),
          )
        ],
      ),
    );
  }
}

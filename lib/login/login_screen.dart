import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:metagamer/change_page.dart';
import 'package:metagamer/current_route.dart';
import 'package:metagamer/login/email_login.dart';
import 'package:metagamer/login/signup.dart';
import 'package:metagamer/model/first_login_model.dart';

import '../appbar.dart';
import '../bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    setRoute(2);
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppbar(),
                Login(),
                KeyboardVisibilityProvider(child: BottomNav())
              ],
            ),
          ),
        ),
        onWillPop: () {
          currentRoute = CurrentRoute.home;
          //여기서 홈으로 task 지우고 돌아가는 코드 짜기
          return Future.value(true);
        },
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(
              "Meta Gamer",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 35),
            LoginScreenButton(
                color: Colors.white,
                image: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Image.asset(
                    "assets/googleicon.png",
                    height: 20.0,
                  ),
                ),
                text: Text(
                  "Google 로그인",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  signInWithGoogle();
                }),
            SizedBox(
              height: 20.0,
            ),
            LoginScreenButton(
                color: Colors.grey.shade300,
                image: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Icon(Icons.email_rounded)),
                text: Text(
                  "Email 로그인",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => EmailLogin(),
                          transitionDuration: Duration.zero));
                }),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("계정이 없으신가요? "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => SignUp(),
                            transitionDuration: Duration.zero));
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> signInWithGoogle() async {
    await GoogleSignIn().disconnect();
    String date = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    print("okok" + googleUser.email);

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final isNew = userCredential.additionalUserInfo!.isNewUser;
    print(isNew);

    if (isNew) {
      await _auth.currentUser!.delete();
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('등록된 회원이 아닙니다.'),
        ),
      );
    }
    return isNew;
  }
}

class LoginScreenButton extends StatelessWidget {
  final Color color;
  final Widget image;
  final Widget text;
  final VoidCallback onPressed;

  const LoginScreenButton(
      {Key? key,
      required this.color,
      required this.image,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              image,
              text,
              Opacity(
                opacity: 0.0,
                child: image,
              )
            ],
          ),
        ));
  }
}

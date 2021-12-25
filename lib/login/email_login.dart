import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:metagamer/current_route.dart';
import 'package:metagamer/dialog/loader.dart';
import 'package:metagamer/dialog/reset_email_password.dart';
import 'package:metagamer/dialog/send_verify_again.dart';
import 'package:metagamer/login/signup.dart';

import '../appbar.dart';
import '../bottom_nav.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  @override
  void initState() {
    // TODO: implement initState
    setRoute(3);
    super.initState();
  }

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
              Center(
                  child: KeyboardVisibilityProvider(child: EditEmailLogin())),
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

class EditEmailLogin extends StatefulWidget {
  const EditEmailLogin({Key? key}) : super(key: key);

  @override
  _EditEmailLoginState createState() => _EditEmailLoginState();
}

class _EditEmailLoginState extends State<EditEmailLogin> {
  final _auth = FirebaseAuth.instance;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  String emailtext = "";
  String passwordtext = "";
  String logintext = "";

  bool isLoad = false;
  bool isAsk = false;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Padding(
      padding: isKeyboardVisible
          ? EdgeInsets.only(top: 70.0)
          : EdgeInsets.symmetric(vertical: 70.0),
      child: SingleChildScrollView(
        child: Container(
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
              Column(
                children: [
                  Text("Email 로그인",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 3.0),
                  Container(
                    height: 3,
                    width: 90,
                    color: Colors.orangeAccent,
                  )
                ],
              ),
              SizedBox(height: 20.0),
              TextField(
                onChanged: (text) {
                  if (text.length != 0) {
                    setState(() {
                      emailtext = "";
                    });
                  }
                },
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
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 5.0),
                      child:
                          Text(emailtext, style: TextStyle(color: Colors.red)))
                ],
              ),
              SizedBox(height: 15.0),
              TextField(
                onChanged: (text) {
                  if (text.length != 0) {
                    setState(() {
                      passwordtext = "";
                    });
                  }
                },
                obscureText: true,
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
                controller: password,
                autofocus: false,
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Text(passwordtext,
                          style: TextStyle(color: Colors.red)))
                ],
              ),
              SizedBox(height: 15.0),
              Text(logintext, style: TextStyle(color: Colors.red)),
              isAsk
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("지금 바로 가입하세요!"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => SignUp(), transitionDuration: Duration.zero));
                            },
                            child: Text(
                              "가입하기",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  : Container(height: 0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                child: Text("로그인"),
                onPressed: () async {
                  setState(() {
                    logintext = "";
                    isAsk = false;
                  });
                  Loader.showLoadingDialog(context);
                  if (email.text.length == 0) {
                    setState(() {
                      emailtext = "이메일을 입력해주세요";
                    });
                  } else if (!email.text.contains(new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
                    setState(() {
                      emailtext = "올바른 이메일을 입력해주세요.";
                    });
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text, password: password.text);
                      if (!_auth.currentUser!.emailVerified) {
                        Loader.closeLoadingDialog();
                        SendVerifyAgain.showSendVerifyAgainDialog(context);
                        _auth.signOut();
                      }
                      Loader.closeLoadingDialog();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        setState(() {
                          logintext = "등록된 이메일이 아닙니다.";
                          isAsk = true;
                        });
                      } else if (e.code == 'wrong-password') {
                        setState(() {
                          passwordtext = "비밀번호가 일치하지 않습니다.";
                        });
                      }
                    }
                  }
                  Loader.closeLoadingDialog();
                },
              ),
              SizedBox(height: 15.0),
              TextButton(onPressed: () {
                ResetEmailPassword.showResetEmailPasswordDialog(context);
              }, child: Text("비밀번호를 잊으셨나요?")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _auth.sendPasswordResetEmail(email: "kmj654649@gmail.com");
                    });
                  },
                  child: Text("test")),
            ],
          ),
        ),
      ),
    );
  }
}

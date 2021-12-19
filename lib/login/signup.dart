import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../appbar.dart';
import '../bottom_nav.dart';
import '../current_route.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          // endDrawerEnableOpenDragGesture: false,
          // drawerEnableOpenDragGesture: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppbar(),
              EditSignUp(),
              KeyboardVisibilityProvider(child: BottomNav()),
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
  final _auth = FirebaseAuth.instance;

  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Text('회원가입'),
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
                    child: Text("완료"),
                  ),
                ],
              )),
        SizedBox(
          height: 20,
        ),
        SizedBox(height: 30, child: TextButton(onPressed: () {}, child: Text("개인정보보호정책"))),
        SizedBox(height: 30,child: TextButton(onPressed: () {}, child: Text("서비스이용약관")))
      ],
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
          Text(widget.text, style: TextStyle(fontSize: 15, color: Colors.red),)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'appbar.dart';
import 'bottom_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CustomAppbar(), Login(), BottomNav()],
          ),
        ),
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            LoginScreenButton(
                color: Colors.white,
                image: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  child: Image.asset(
                    "assets/googleicon.png",
                    height: 20.0,
                  ),
                ),
                text: Text("Google 로그인", style: TextStyle(color: Colors.black),),
                onPressed: () {}),
            SizedBox(
              height: 20.0,
            ),
            LoginScreenButton(
                color: Colors.grey.shade300,
                image: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  child: Icon(Icons.email_rounded)
                ),
                text: Text("Email 로그인", style: TextStyle(color: Colors.black),),
                onPressed: () {}),
            SizedBox(
              height: 20.0,
            ),
            LoginScreenButton(
                color: Colors.indigoAccent,
                image: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Icon(Icons.account_circle)
                ),
                text: Text("회원가입", style: TextStyle(color: Colors.white),),
                onPressed: () {})
          ],
        ),
      ),
    );
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
          onPressed: () {},
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

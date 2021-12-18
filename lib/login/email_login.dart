import 'package:flutter/material.dart';

import '../appbar.dart';
import '../bottom_nav.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CustomAppbar(), EditEmailLogin(), BottomNav()],
          ),
        ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
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
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
            // ModalRoute.of(context)!.settings.name;
          },
          child: Text('test'),
        ),
      ),
    );
  }
}

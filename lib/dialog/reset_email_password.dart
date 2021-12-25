import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metagamer/dialog/success_send_email_reset_password.dart';

class ResetEmailPassword {
  static bool _isLoading = false;
  static late BuildContext _context;

  static void closeResetEmailPasswordDialog() {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
  }

  static void showResetEmailPasswordDialog(BuildContext context) async {
    _context = context;

    TextEditingController email = new TextEditingController();

    String emailtext = "";

    if (!_isLoading) {
      _isLoading = true;
      await showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ResetEmailPasswordDialog();
          });
    }
  }
}

class ResetEmailPasswordDialog extends StatefulWidget {
  const ResetEmailPasswordDialog({Key? key}) : super(key: key);

  @override
  _ResetEmailPasswordDialogState createState() =>
      _ResetEmailPasswordDialogState();
}

class _ResetEmailPasswordDialogState extends State<ResetEmailPasswordDialog> {
  final _auth = FirebaseAuth.instance;
  TextEditingController email = new TextEditingController();

  bool isWait = false;

  String emailtext = "";

  bool isPage1 = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        children: <Widget>[
          Center(
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
              child: isPage1 ? Column(
                children: [
                  Text("비밀번호 재설정"),
                  Text("받은 이메일에서 비번 재설정"),
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
                          Icons.password,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        hintText: "비밀번호 확인",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.all(10.0)),
                    controller: email,
                    autofocus: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                          child: Text(emailtext,
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center))
                    ],
                  ),
                  !isWait
                      ? Column(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isWait = true;
                                  });
                                  if (email.text.length == 0) {
                                    setState(() {
                                      emailtext = "이메일을 입력해주세요";
                                      isWait = false;
                                    });
                                  } else if (!email.text.contains(new RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
                                    setState(() {
                                      emailtext = "올바른 이메일 주소를 입력해주세요";
                                      isWait = false;
                                    });
                                  } else {
                                    try {
                                      await _auth.sendPasswordResetEmail(
                                          email: email.text);
                                      setState(() {
                                        isPage1 = false;
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      if (e.code == 'user-not-found') {
                                        setState(() {
                                          emailtext =
                                              "등록된 이메일이 아닙니다.\n다시 확인해주세요.";
                                          isWait = false;
                                        });
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                      isWait = false;
                                    }
                                  }
                                },
                                child: Text("확인")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ResetEmailPassword._isLoading = false;
                                },
                                child: Text("취소")),
                          ],
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  null;
                                },
                                child: Text("확인")),
                            ElevatedButton(
                                onPressed: () {
                                  null;
                                },
                                child: Text("취소")),
                          ],
                        )
                ],
              ) : Column(
                children: [
                  Text("비밀번호 재설정"),
                  Text("받은 이메일에서 비번 재설정"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ResetEmailPassword._isLoading = false;
                      },
                      child: Text("확인")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendVerifyAgain {
  static bool _isLoading = false;
  static late BuildContext _context;

  static void closeSendVerifyAgainDialog() {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
  }

  static void showSendVerifyAgainDialog(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    _context = context;

    if (!_isLoading) {
      _isLoading = true;
      await showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) {
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
                      child: Column(
                        children: [
                          Text("Email 인증"),
                          Text("이메일 인증이 완료되지 않았습니다."),
                          Text("메일 확인 후 다시 아님 다시보내기"),
                          ElevatedButton(onPressed: () async {
                            await _auth.currentUser!.sendEmailVerification();
                              }, child: Text("다시보내기")),
                          ElevatedButton(onPressed: () {closeSendVerifyAgainDialog();}, child: Text("확인"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }
}

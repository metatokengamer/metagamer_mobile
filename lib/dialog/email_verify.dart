import 'package:flutter/material.dart';

class EmailVerify {
  static bool _isLoading = false;
  static late BuildContext _context;

  static void closeEmailVerifyDialog() {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
  }

  static void showEmailVerifyDialog(BuildContext context, String email) async {
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
                          Text(email + " 로 인증 메일이 전송되었습니다"),
                          Text("메일에 인증버튼 눌른 후 다시 로그인해주세용"),
                          ElevatedButton(onPressed: () {closeEmailVerifyDialog();}, child: Text("확인"))
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

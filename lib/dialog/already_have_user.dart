import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlreadyHaveUser {
  static bool _isLoading = false;
  static late BuildContext _context;
  static bool willLogin = false;

  static void closeAlreadyHaveUserDialog(BuildContext context) {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
    if (willLogin) {
      Navigator.of(context).pop();
      willLogin = false;
    }
  }

  static void showAlreadyHaveUserDialog(BuildContext context) async {
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
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
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
                          Text("이미 등록된 이메일 입니다."),
                          Text("지금 바로 로그인 하시겠습니까?"),
                          ElevatedButton(
                              onPressed: () {
                                willLogin = true;
                                closeAlreadyHaveUserDialog(context);
                              },
                              child: Text("확인")),
                          ElevatedButton(
                              onPressed: () {
                                willLogin = false;
                                closeAlreadyHaveUserDialog(context);
                              },
                              child: Text("취소")),
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

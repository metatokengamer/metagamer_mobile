import 'package:flutter/material.dart';

class Loader {
  static bool _isLoading = false;
  static late BuildContext _context;

  static void closeLoadingDialog() {
    if (_isLoading) {
      _isLoading = false;
      Navigator.of(_context).pop();
    }
  }

  static void showLoadingDialog(BuildContext context) async {
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
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }
}

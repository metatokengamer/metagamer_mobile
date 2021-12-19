import 'package:flutter/material.dart';
import 'package:metagamer/login/email_login.dart';

import 'login/login_screen.dart';

Route goToLogin() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(), transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

Route goToEmailLogin() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const EmailLogin(), transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
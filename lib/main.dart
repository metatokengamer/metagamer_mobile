import 'package:flutter/material.dart';
import 'package:metagamer/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:metagamer/current_route.dart';
import 'package:metagamer/login/email_login.dart';
import 'package:metagamer/main_page.dart';

import 'bottom_nav.dart';
import 'login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

// class MyCustomRoute<T> extends MaterialPageRoute<T> {
//   MyCustomRoute({ required WidgetBuilder builder, required RouteSettings settings })
//       : super(builder: builder, settings: settings);
//
//   @override
//   Widget buildTransitions(BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//     if (settings.isInitialRoute)
//       return child;
//     // Fades between routes. (If you don't want any animation,
//     // just return child.)
//     return new FadeTransition(opacity: animation, child: child);
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MetaGamer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // onGenerateRoute: (settings) {
      //   if (settings == "/login") {
      //     return PageRouteBuilder(pageBuilder: (a, a1, a2) => LoginScreen());
      //   } else if (settings == "/login/email_login") {
      //     return PageRouteBuilder(pageBuilder: (a, a1, a2) => EmailLogin());
      //   }
      // },

      // initialRoute: "/home",      onGenerateRoute: (RouteSettings settings) {
      //   switch (settings.name) {
      //     case "/home": return MaterialPageRoute(
      //       builder: (BuildContext context) => new HomePage(),
      //       settings: settings
      //     );
      //     case "/login": return MaterialPageRoute(
      //         builder: (BuildContext context) => new LoginScreen(),
      //         settings: settings
      //     );
      //     case "/email_login": return MaterialPageRoute(
      //         builder: (BuildContext context) => new EmailLogin(),
      //         settings: settings
      //     );
      //     default:
      //       throw Exception('Invalid route: ${settings.name}');
      //   }
      // },

      // initialRoute: "/home",
      // routes: {
      //   "/home": (context) => HomePage(),
      //   "/login": (context) => LoginScreen(),
      //   "/login/email_login": (context) => EmailLogin()
      // },

      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setRoute(1);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppbar(),
              MainPage(),
              BottomNav()
            ],
          ),
        ),
      ),
    );
  }
}

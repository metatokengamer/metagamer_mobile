import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:metagamer/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:metagamer/boad_page.dart';
import 'package:metagamer/current_route.dart';
import 'package:metagamer/login/email_login.dart';
import 'package:metagamer/login/signup.dart';
import 'package:metagamer/main_page.dart';

import 'bottom_nav.dart';
import 'login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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

      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => LoginScreen(),
        "/login/email_login": (context) => EmailLogin(),
        "/login/signup":(context) => SignUp(),
        "/boad":(context) => BoadPage()
      },

      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime pre_backpress = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    setRoute(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            final snack = SnackBar(content: Text("한번더눌러서종료"), duration: Duration(seconds: 2));
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppbar(),
                MainPage(),
                KeyboardVisibilityProvider(child: BottomNav())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

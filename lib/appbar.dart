import 'package:flutter/material.dart';
import 'package:metagamer/change_page.dart';
import 'package:metagamer/login_screen.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu),
          Text("MetaGamer"),
          Login()
        ],
      ),
    );
  }
}

class LoginAready extends StatelessWidget {
  const LoginAready({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: CircleAvatar(radius: 50, backgroundColor: Colors.grey),
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.indigo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        onPressed: () {
          print(ModalRoute.of(context)!.settings.name);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          // Navigator.of(context).push(goToLogin());
          // Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, a, b) => LoginScreen(), transitionDuration: Duration.zero));
          // Navigator.pushNamed(context, "/login");

          // Navigator.pushNamed(context, PageRouteBuilder(pageBuilder: (context, a1, a2) => , transitionDuration: Duration.zero));
          Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginScreen(), transitionDuration: Duration.zero));
        },
        child: Text("Login"),
      ),
    );
  }
}

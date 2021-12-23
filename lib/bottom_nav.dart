import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:metagamer/current_route.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    if (isKeyboardVisible) {
      return Bottomh();
    } else {
      return Bottom();
    }

    // return Bottom();
  }
}

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(onPressed: () {
          if (currentRoute != CurrentRoute.home) {
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          }
        }, child: Text("home1")),
        OutlinedButton(onPressed: () {}, child: Text("home2")),
        OutlinedButton(onPressed: () {}, child: Text("home3")),
        OutlinedButton(onPressed: () {}, child: Text("home4")),
        OutlinedButton(onPressed: () {}, child: Text("home5")),
      ],
    );
  }
}

class Bottomh extends StatefulWidget {
  const Bottomh({Key? key}) : super(key: key);

  @override
  _BottomhState createState() => _BottomhState();
}

class _BottomhState extends State<Bottomh> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 0.0,);
  }
}

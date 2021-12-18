import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(onPressed: () {}, child: Text("home1")),
        OutlinedButton(onPressed: () {}, child: Text("home2")),
        OutlinedButton(onPressed: () {}, child: Text("home3")),
        OutlinedButton(onPressed: () {}, child: Text("home4")),
        OutlinedButton(onPressed: () {}, child: Text("home5")),
      ],
    );
  }
}

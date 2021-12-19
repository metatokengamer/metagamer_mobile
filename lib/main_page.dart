import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FirstBoad(),
            FirstBoad(),
            FirstBoad(),
            FirstBoad(),
            FirstBoad(),
          ],
        ),
      ),
    );
  }
}

class FirstBoad extends StatefulWidget {
  const FirstBoad({Key? key}) : super(key: key);

  @override
  _FirstBoadState createState() => _FirstBoadState();
}

class _FirstBoadState extends State<FirstBoad> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        height: 200,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("최신글"),
                ],
              ),
              Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(opacity: 0.0),
                  TextButton(onPressed: () {null;}, child: Text("더보기"),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
